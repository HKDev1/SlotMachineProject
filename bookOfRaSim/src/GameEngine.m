classdef GameEngine
    % GameEngine - Kernklasse, die den Spielablauf steuert und den Zustand des Spiels verwaltet.
    %
    % Diese Klasse ist verantwortlich für die Kontrolle des Spielablaufs und die Verwaltung des Spielzustands.
    % Sie fungiert als zentrale Steuerungseinheit, die Spielereignisse koordiniert, den Spielstand aktualisiert und 
    % die Interaktionen zwischen den verschiedenen Spielkomponenten orchestriert.
    %
    % Eigenschaften:
    %   currentState - Der aktuelle Zustand des Spiels, z. B. 'waitingForBet', 'spinning', 'payingOut'.
    %   playerProfile - Eine Instanz der Klasse PlayerProfile, die die Daten des Spielers verwaltet.
    %   reels - Ein Array von Reel-Objekten, die die Walzen des Spielautomaten kontrollieren.
    %   balance - Das aktuelle Guthaben des Spielers.

    properties
        currentState
        playerProfile
        reels
        balance
        currentBet
    end

    methods
        function obj = GameEngine(playerProfile, reels)
            % Konstruktor, der die GameEngine instanziiert und initialisiert.
            obj.playerProfile = playerProfile;
            obj.reels = reels;
            obj.currentState = 'waitingForBet';
            obj.balance = playerProfile.balance;
            obj.currentBet = 0;
        end

        function spinReels(obj)
            % Startet den Drehvorgang der Walzen.
            if strcmp(obj.currentState, 'waitingForBet') && obj.balance > 0
                obj.currentState = 'spinning';
                for i = 1:length(obj.reels)
                    obj.reels(i).spin();
                end
            end
        end

        function stopReels(obj)
            % Stoppt die Walzen und berechnet das Ergebnis des Spins.
            if strcmp(obj.currentState, 'spinning')
                for i = 1:length(obj.reels)
                    obj.reels(i).stop(randi(length(obj.reels(i).symbols))); % Zufällige Stopposition
                end
                winnings = obj.calculateWinnings(); % Berechnet die Gewinne
                obj.updateBalance(winnings);
                obj.currentState = 'waitingForBet';
            end
        end

        function winnings = calculateWinnings(obj)
            % Berechnet Gewinne nach dem Anhalten der Walzen.
            results = arrayfun(@(reel) reel.getCurrentSymbol(), obj.reels); % Annahme, dass getCurrentSymbol die sichtbaren Symbole liefert
            % Beispielhafte Logik zur Berechnung von Gewinnen:
            winnings = sum(arrayfun(@(symbol) symbol.value, results)); % Summiert die Werte der sichtbaren Symbole
        end

        function updateBalance(obj, amount)
            % Aktualisiert das Guthaben des Spielers.
            obj.balance = obj.balance + amount;
            obj.playerProfile.updateBalance(amount);
        end

        function enterBet(obj, betAmount)
            % Verarbeitet den Einsatz des Spielers.
            if betAmount <= obj.balance
                obj.currentBet = betAmount;
                obj.balance = obj.balance - betAmount;
                obj.currentState = 'readyToSpin';
            else
                error('Betrag zu hoch oder nicht genügend Guthaben');
            end
        end
    end
end
