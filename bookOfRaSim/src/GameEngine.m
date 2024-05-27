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
        reels
        spinController
        payoutCalculator
        bonusManager
        historyTracker
        playerBalance
        currentBet
    end

    methods
        function obj = GameEngine(numReels, numSymbols)
                % Constructor initializes the game engine and its components.
                obj.reels = Reel.empty(numReels, 0);
                for i = 1:numReels
                    obj.reels(i) = Reel(numSymbols);
                end
                obj.spinController = SpinController(numReels);
                obj.payoutCalculator = PayoutCalculator();
                obj.bonusManager = BonusManager();
                obj.historyTracker = HistoryTracker();
                obj.playerBalance = 1000; % Initial player balance
                obj.currentBet = 10; % Default bet amount
            end
    
            function play(obj)
                % Main game loop
                while obj.playerBalance > 0
                    obj.placeBet();
                    spinResults = obj.spinController.spin(obj.reels);
                    obj.historyTracker.logEvent('spin', spinResults);
                    
                    payout = obj.payoutCalculator.calculatePayout(spinResults, obj.currentBet);
                    obj.historyTracker.logEvent('payout', payout);
    
                    obj.applyPayout(payout);
                    obj.bonusManager.checkBonusConditions(struct('spins', obj.spinController.spinCount, 'balance', obj.playerBalance));
                    
                    obj.displayResults(spinResults, payout);
                end
                disp('Game over! Your balance is zero.');
            end
    
            function placeBet(obj)
                % Place a bet for the current spin
                if obj.playerBalance >= obj.currentBet
                    obj.playerBalance = obj.playerBalance - obj.currentBet;
                    obj.historyTracker.logEvent('betPlaced', obj.currentBet);
                else
                    error('Insufficient balance to place the bet.');
                end
            end
    
            function applyPayout(obj, payout)
                % Apply the payout to the player's balance
                obj.playerBalance = obj.playerBalance + payout;
                obj.historyTracker.logEvent('balanceUpdated', obj.playerBalance);
            end
    
            function displayResults(obj, spinResults, payout)
                % Display the spin results and the payout
                disp('Spin results:');
                disp(spinResults);
                disp(['Payout: ', num2str(payout)]);
                disp(['Current balance: ', num2str(obj.playerBalance)]);
            end
    end
end