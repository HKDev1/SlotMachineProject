classdef ConfigManager
    % ConfigManager - Lädt und verwaltet Konfigurationseinstellungen, die das Spielverhalten wie Spin-Geschwindigkeit, Gewinnchancen und mehr anpassen können.
    %
    % Diese Klasse ist verantwortlich für das Laden, Speichern und Verwalten von Konfigurationseinstellungen, die verschiedene Aspekte des Spiels beeinflussen.
    % Sie ermöglicht es, Spielparameter dynamisch anzupassen und bietet Schnittstellen für andere Komponenten des Systems, um auf diese Einstellungen zuzugreifen.
    %
    % Eigenschaften:
    %   settings - Ein Container, der alle Konfigurationseinstellungen speichert.
    %
    % Methoden:
    %   loadSettings - Lädt Einstellungen aus einer Datei oder einer externen Quelle.
    %   saveSettings - Speichert die aktuellen Einstellungen in einer Datei oder externen Quelle.
    %   getSetting - Gibt eine spezifische Einstellung zurück.
    %   updateSetting - Aktualisiert den Wert einer spezifischen Einstellung.

    properties
        settings
    end

    methods
        function obj = ConfigManager()
            % Konstruktor, der die ConfigManagerinstanz initialisiert und Einstellungen lädt.
            obj.settings = containers.Map;
            obj.loadSettings();
        end

        function loadSettings(obj)
            % Lädt die Einstellungen aus einer Datei oder Datenbank.
            % Hier wird Pseudocode verwendet, um den Ladevorgang zu beschreiben:
            obj.settings('spinSpeed') = 1.0; % Standardgeschwindigkeit der Walzendrehung
            obj.settings('payoutRatio') = 0.85; % Standardauszahlungsverhältnis
        end

        function saveSettings(obj)
            % Speichert die aktuellen Einstellungen in einer Datei oder Datenbank.
            % Pseudocode für den Speichervorgang:
            fileID = fopen('config.txt', 'w');
            fwrite(fileID, jsonencode(obj.settings));
            fclose(fileID);
        end

        function value = getSetting(obj, key)
            % Gibt den Wert einer spezifischen Einstellung zurück.
            if isKey(obj.settings, key)
                value = obj.settings(key);
            else
                value = [];
                warning('Setting %s not found.', key);
            end
        end

        function updateSetting(obj, key, newValue)
            % Aktualisiert den Wert einer spezifischen Einstellung.
            if isKey(obj.settings, key)
                obj.settings(key) = newValue;
            else
                warning('Setting %s not found. No update performed.', key);
            end
        end
    end
end
