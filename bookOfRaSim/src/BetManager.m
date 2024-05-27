classdef BetManager
    % BetManager - Verwaltet Einsätze, einschließlich der Einstellung des Einsatzbetrags und der Berechnung von Gewinnen basierend auf den Ergebnissen der Spins.
    %
    % Diese Klasse ist zuständig für die Verwaltung aller Wettaktivitäten im Spiel. Sie nimmt Einsätze entgegen,
    % speichert diese und berechnet Gewinne, basierend auf den Ergebnissen der Spins und den festgelegten Auszahlungsregeln.
    %
    % Eigenschaften:
    %   currentBet - Der aktuelle Wetteinsatz des Spielers.
    %   totalBet - Die Gesamtsumme aller Einsätze in einer Spielsession.
    %   payoutRates - Eine Tabelle oder ein Array, das die Auszahlungsraten für verschiedene Symbolkombinationen angibt.
    %
    % Methoden:
    %   placeBet - Nimmt einen Wetteinsatz entgegen und aktualisiert die Wettsummen.
    %   calculatePayout - Berechnet den Gewinn basierend auf dem Ergebnis des Spins und den Auszahlungsraten.
    %   resetBets - Setzt alle Wettinformationen zurück, um für eine neue Spielrunde vorzubereiten.

    properties
        currentBet
        totalBet
        payoutRates
    end

    methods
        function obj = BetManager()
            % Konstruktor, der die Wettmanagerinstanz initialisiert.
            obj.currentBet = 0;
            obj.totalBet = 0;
            obj.payoutRates = {}; % Hier könnten spezifische Auszahlungsraten eingefügt werden
        end

        function obj = placeBet(obj, amount)
            % Nimmt einen Wetteinsatz entgegen und aktualisiert die Wettsummen.
            obj.currentBet = amount;
            obj.totalBet = obj.totalBet + amount;
        end

        function payout = calculatePayout(obj, result)
            % Berechnet den Gewinn basierend auf dem Ergebnis des Spins.
            % 'result' wäre ein Parameter, der die gewinnende Symbolkombination angibt.
            payout = obj.currentBet * obj.payoutRates(result);
            obj.currentBet = 0; % Setzt den aktuellen Einsatz nach der Auszahlung zurück
            % Berechnet den Gewinn basierend auf dem Ergebnis des Spins.
            % 'result' wäre ein Parameter, der die gewinnende Symbolkombination angibt.
            payout = obj.currentBet * obj.payoutRates(result);
            obj.currentBet = 0; % Setzt den aktuellen Einsatz nach der Auszahlung zurück
            payout = obj; % Return the modified object
        end
        function obj = resetBets(obj)
            % Setzt alle Wettinformationen zurück, um für eine neue Spielrunde vorzubereiten.
            obj.currentBet = 0;
            obj.totalBet = 0;
        end
    end
end

