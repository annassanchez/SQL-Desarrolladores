' Aggiungere i riferimenti a:
' Microsoft.SqlServer.ConnectionInfo
' Microsoft.SqlServer.Smo
' Microsoft.SqlServer.SmoEnum
' Microsoft.SqlServer.SqlEnum

Imports Microsoft.SqlServer.Management.Smo
Imports Microsoft.SqlServer.Management.Common

Public Class SmoConnector

    Private _server As Server
    Private _database As Database
    Private _table As Table
    Private _serverExists As Boolean = False
    Private _databasesExists As Boolean = False
    Private _serverName As String
    Private _userName As String
    Private _password As String
    Private _isWindowsAuthentication As Boolean = False

#Region "Costruttori"
    ''' <summary>
    ''' Inizializza l'oggetto
    ''' </summary>
    Sub New()

    End Sub

#End Region

#Region "Proprietà Pubbliche"

    ''' <summary>
    ''' Password per la login di SQL Server
    ''' </summary>
    Public Property Password() As String
        Get
            Return _password
        End Get
        Set(ByVal value As String)
            _password = value
        End Set
    End Property

    ''' <summary>
    ''' Ottiene o imposta l'Utente per la login di SQL Server
    ''' </summary>
    Public Property UserName() As String
        Get
            Return _userName
        End Get
        Set(ByVal value As String)
            _userName = value
        End Set
    End Property

    ''' <summary>
    ''' Ottiene o imposta il tipo di connessione al server
    ''' </summary>
    Public Property IsWindowsAuthentication() As Boolean
        Get
            Return _isWindowsAuthentication
        End Get
        Set(ByVal value As Boolean)
            _isWindowsAuthentication = value
        End Set
    End Property

    ''' <summary>
    ''' Ottiene il server selezionato
    ''' </summary>
    Public ReadOnly Property Server() As Server
        Get
            Return Me.ServerInstance
        End Get
    End Property

    ''' <summary>
    ''' Ottiene o imposta il server selezionato in un contesto privato
    ''' </summary>
    Private Property ServerInstance() As Server
        Get
            Return _server
        End Get
        Set(ByVal value As Server)
            _server = value
        End Set
    End Property

    ''' <summary>
    ''' Ottiene la tabella selezionata
    ''' </summary>
    Public ReadOnly Property Table() As Table
        Get
            Return _table
        End Get
    End Property

    ''' <summary>
    ''' Ritorna true se i database sono accessibili
    ''' </summary>
    Public ReadOnly Property DataBasesExists() As Boolean
        Get
            Return _databasesExists
        End Get
    End Property

    ''' <summary>
    ''' Ottiene o imposta la stringa del nome del server
    ''' </summary>
    Public Property ServerName() As String
        Get
            Return _serverName
        End Get
        Set(ByVal value As String)
            _serverName = value
        End Set
    End Property

    ''' <summary>
    ''' Ottiene la lista dei database di un server
    ''' </summary>
    Public ReadOnly Property DataBases() As DatabaseCollection
        Get
            ' se il server esiste ricavo l'eventuale lista dei db
            Try
                ' ricavo la lista dei database, se ne esistono
                If Me.Server.Databases.Count > 0 Then
                    Return Me.Server.Databases
                Else
                    ' lancio l'eccezione
                    Throw New SmoException(String.Format("Non vi sono database disponibili sul server {0}", Me.ServerName))
                End If
            Catch ex As Exception
                ' lancio l'eccezione sql
                If Me.IsWindowsAuthentication Then
                    Throw New SmoException(String.Format("Errore di connessione al server, SQL Server inesistente o accesso negato sul server() '{0}' con Windows Authentication", Me.ServerName))
                Else
                    Throw New SmoException(String.Format("Errore di connessione al server, SQL Server inesistente o accesso negato sul server() '{0}' con login '{1}'", Me.ServerName, Me.UserName))
                End If
            End Try
        End Get
    End Property

#End Region

#Region "Metodi pubblici"

    ''' <summary>
    ''' Inizializza l'oggetto per la WindowsAuthentication
    ''' </summary>
    Public Sub Connect()

        ' controllo se il nome del server è presente
        If String.IsNullOrEmpty(Me.ServerName) Then
            Throw New NullReferenceException("Server name non valido. Impostare la proprietà 'ServerName'")
        End If

        ' imposto user e password solo se non ho Win Auth
        If Not Me.IsWindowsAuthentication Then

            ' imposto nome del Server e tipo di connessione
            Dim conn As New ServerConnection(Me.ServerName)
            conn.LoginSecure = Me.IsWindowsAuthentication

            ' controllo se il nome del login è presente
            If String.IsNullOrEmpty(Me.UserName) Then
                Throw New NullReferenceException("Username non valida. Impostare la proprietà 'UserName'.")
            End If

            ' imposto UserName e Password
            conn.Login = Me.UserName
            conn.Password = Me.Password

            ' ritorno un'istanza di server in contesto privato
            Me.ServerInstance = New Server(conn)

        Else
            ' in windows authentication non c'è da impostare nulla. Torno solo l'istanza in base al nome del server.
            Me.ServerInstance = New Server(ServerName)
        End If

    End Sub

    ''' <summary>
    ''' Ritorna la lista delle tabelle di uno schema
    ''' </summary>
    Public Function GetTables(ByVal DataBaseName As String) As TableCollection

        ' se il server contiene il database ritorno l'elenco delle eventuali tabelle
        If Me.Server.Databases.Contains(DataBaseName) Then
            Return Me.Server.Databases(DataBaseName).Tables
        Else
            Throw New SmoException(String.Format("'{0}' non è più disponibile", DataBaseName))
        End If

    End Function

    ''' <summary>
    ''' Ritorna l'oggetto tabella
    ''' </summary>
    Public Function GetTable(ByVal DatabaseName As String, ByVal TableName As String, ByVal SchemaName As String) As Table

        If Me.GetTables(DatabaseName).Contains(TableName, SchemaName) Then
            Return Me.GetTables(DatabaseName)(TableName, SchemaName)
        Else
            Throw New SmoException(String.Format("'{0}' non è più disponibile", TableName))
        End If

    End Function

    ''' <summary>
    ''' Ricava la primary key dalla tabella
    ''' </summary>
    Public Function GetPrimaryKeyField(ByVal smoTable As Table) As PrimaryKeyCollection
        Dim PK As New PrimaryKeyCollection

        For Each c As Column In smoTable.Columns
            If c.InPrimaryKey Then
                PK.Add(c.Name)
            End If
        Next

        Return PK
    End Function

    ''' <summary>
    ''' Genera lo script per la creazione di una tabella
    ''' </summary>
    Public Function GenerateScript(ByVal FileName As String, ByVal TableName As String) As String

        Dim strScript As String = String.Empty
        ' oggetto per le opzioni di output dello script
        Dim scriptOpt As New ScriptingOptions()

        ' imposto le opzioni

        ' script del clustered
        scriptOpt.ClusteredIndexes = True
        ' script delle dipendenze
        scriptOpt.DriForeignKeys = True
        scriptOpt.DriPrimaryKey = True
        scriptOpt.DriUniqueKeys = True
        ' script della clausola if not exists
        scriptOpt.IncludeIfNotExists = True
        ' script del solo drop
        scriptOpt.ScriptDrops = False

        ' output
        scriptOpt.FileName = FileName

        ' Generazione script
        Try


            Dim str As String = String.Empty

            ' per ogni stringa ricavata dal metodo Script (con opzioni preimpostate)
            For Each s As String In Me.DataBases("DWH_IBetParadise").Tables("DimCustomerAccounts", "Customers").Script(scriptOpt)
                str &= s
            Next

            Return str

        Catch ex As Exception

            Return String.Empty

        End Try

    End Function


#End Region

End Class


Public Class PrimaryKeyCollection
    Inherits List(Of String)

    ''' <summary>
    ''' Se = true la primary key è composta da più colonne
    ''' </summary>
    Public ReadOnly Property ChiaveMultipla() As Boolean
        Get
            Return Me.Count > 1
        End Get
    End Property


    ''' <summary>
    ''' Nome della colonna della primary key a Chiave Singola
    ''' </summary>
    Public ReadOnly Property NomeColonnaChiaveSingola() As String
        Get
            If Me.Count = 0 Then
                Throw New ApplicationException("Chiave Primaria non definita")
            End If

            Return Me(0)
        End Get
    End Property

    ''' <summary>
    ''' Inserisce una colonna
    ''' </summary>
    Public Shadows Sub Add(ByVal ColumnName As String)
        If _FindIndex(ColumnName) = -1 Then
            MyBase.Add(ColumnName)
        End If
    End Sub


    ''' <summary>
    ''' Ricerca l'indice di una colonna
    ''' </summary>
    Private Function _FindIndex(ByVal ColumnName As String) As Integer

        For i As Integer = 0 To Me.Count - 1
            If Me(i) = ColumnName Then
                Return i
            End If
        Next

        Return -1

    End Function

End Class