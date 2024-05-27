classdef UIController
    % UIController - Steuert die Benutzeroberfläche des Slot-Machine-Simulators und verwaltet die Interaktion mit dem Benutzer.
    %
    % Diese Klasse ist verantwortlich für die Darstellung aller grafischen Benutzerelemente und die Handhabung
    % der Benutzerinteraktionen. Sie aktualisiert die Benutzeroberfläche basierend auf den Spielereignissen und
    % ermöglicht es dem Spieler, Eingaben wie Wetten zu platzieren und Spins zu starten.
    %
    % Eigenschaften:
    %   mainFrame - Das Hauptfenster der Benutzeroberfläche.
    %   spinButton - Eine Schaltfläche, die den Spin-Prozess startet.
    %   betInput - Ein Eingabefeld für Wetteinsätze.
    %   statusLabel - Ein Textfeld zur Anzeige von Nachrichten (z.B. Gewinn- und Verlustmeldungen).
    %
    % Methoden:
    %   updateDisplay - Aktualisiert Elemente der Benutzeroberfläche basierend auf den Änderungen im Spielzustand.
    %   enableUserInput - Ermöglicht es dem Benutzer, Eingaben zu tätigen, wenn das Spiel in einem entsprechenden Zustand ist.
    %   disableUserInput - Verhindert Benutzereingaben während kritischer Spielphasen.
    %   showResults - Zeigt das Ergebnis eines Spins an, z.B. gewonnene oder verlorene Beträge.

    properties
        mainFrame
        spinButton
        betInput
        statusLabel
    end

    methods
        function obj = UIController()
            % Konstruktor, der die Benutzeroberfläche initialisiert und alle notwendigen UI-Komponenten erstellt.
            obj.mainFrame = figure('Name', 'Slot Machine', 'NumberTitle', 'off');
            obj.spinButton = uicontrol('Style', 'pushbutton', 'String', 'Spin');
            obj.betInput = uicontrol('Style', 'edit');
            obj.statusLabel = uicontrol('Style', 'text');
        end

        function updateDisplay(obj, gameState)
            % Aktualisiert die Benutzeroberfläche basierend auf den Zuständen des Spiels.
            % 'gameState' ist eine Instanz von GameEngine.
            set(obj.statusLabel, 'String', sprintf('Your balance is: %d', gameState.playerProfiles.balance));
        end

        function enableUserInput(obj)
            % Ermöglicht Benutzereingaben.
            set(obj.spinButton, 'Enable', 'on');
            set(obj.betInput, 'Enable', 'on');
        end

        function disableUserInput(obj)
            % Verhindert Benutzereingaben während des Spins.
            set(obj.spinButton, 'Enable', 'off');
            set(obj.betInput, 'Enable', 'off');
        end

        function showResults(obj, result)
            % Zeigt das Ergebnis eines Spins an.
            set(obj.statusLabel, 'String', sprintf('You %s! Your payout is: %d', result.message, result.payout));
        end
    end
end
