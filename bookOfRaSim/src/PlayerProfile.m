classdef PlayerProfile
    % PlayerProfile - Verwaltet Spielerdaten, einschließlich Guthaben, Spielhistorie und Einstellungen.
    %
    % Diese Klasse ist dafür verantwortlich, die persönlichen und spielbezogenen Daten eines Spielers zu speichern und zu verwalten.
    % Sie ermöglicht den Zugriff auf Spielerprofile, um das Guthaben zu aktualisieren, die Spielhistorie zu verfolgen und
    % individuelle Spielerpräferenzen zu speichern.
    %
    % Eigenschaften:
    %   username - Der Benutzername des Spielers.
    %   balance - Das aktuelle Guthaben des Spielers.
    %   history - Eine Instanz von HistoryTracker, die die Spielaktivitäten des Spielers speichert.
    %   settings - Eine Map oder ein Struct, das die Spielereinstellungen speichert.
    %
    % Methoden:
    %   updateBalance - Aktualisiert das Guthaben des Spielers.
    %   addGameToHistory - Fügt ein neues Spiel zur Historie hinzu.
    %   updateSettings - Aktualisiert die Einstellungen des Spielers.
    %   resetProfile - Setzt das Profil auf die Standardwerte zurück.

    properties
        username
        balance
        history
        settings
    end

    methods
        function obj = PlayerProfile(username)
            % Konstruktor, der das Spielerprofil initialisiert.
            obj.username = username;
            obj.balance = 0;
            obj.history = HistoryTracker();
            obj.settings = containers.Map;
        end

        function obj = updateBalance(obj, amount)
            % Aktualisiert das Guthaben des Spielers.
            % 'amount' kann positiv (Gewinn) oder negativ (Verlust) sein.
            obj.balance = obj.balance + amount;
        end

        function obj = addGameToHistory(obj, gameData)
            % Fügt ein neues Spiel zur Spielhistorie hinzu.
            obj.history.logEvent('gamePlayed', gameData);
        end

        function obj = updateSettings(obj, settingKey, settingValue)
            % Aktualisiert spezifische Einstellungen für den Spieler.
            obj.settings(settingKey) = settingValue;
        end

        function obj = resetProfile(obj)
            % Setzt das Profil auf die Standardwerte zurück.
            obj.balance = 0;
            obj.history.clearHistory();
            obj.settings = containers.Map;
        end
    end
end
