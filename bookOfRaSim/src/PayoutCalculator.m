classdef PayoutCalculator
    % PayoutCalculator - Berechnet Auszahlungen basierend auf den Kombinationen von Symbolen und den Spielregeln.
    %
    % Diese Klasse ist dafür verantwortlich, die Gewinne zu berechnen, die den Spielern ausgezahlt werden,
    % basierend auf den Kombinationen von Symbolen, die auf den Walzen erscheinen. Sie verwendet festgelegte
    % Auszahlungsregeln, um die Gewinnsummen zu bestimmen.
    %
    % Eigenschaften:
    %   payoutTable - Eine Tabelle oder ein Array, das die Auszahlungswerte für verschiedene Symbolkombinationen speichert.
    %   reelResults - Die Ergebnisse der letzten Drehung der Walzen, verwendet zur Bestimmung der Gewinne.
    %
    % Methoden:
    %   calculatePayout - Berechnet die Auszahlung basierend auf den Ergebnissen der Walzen.
    %   updatePayoutTable - Aktualisiert die Auszahlungstabelle, falls Änderungen an den Auszahlungsregeln vorgenommen werden.
    %   resetCalculator - Setzt den Rechner zurück, um für eine neue Spielrunde bereit zu sein.

    properties
        payoutTable
        reelResults
    end

    methods
        function obj = PayoutCalculator(payoutTable)
            % Konstruktor, der die Auszahlungstabelle initialisiert.
            obj.payoutTable = payoutTable;
            obj.reelResults = [];
        end

        function payout = calculatePayout(obj)
            % Berechnet die Auszahlung basierend auf den Ergebnissen der Walzen.
            % Hier würde die Logik stehen, wie die Symbole ausgewertet und die Auszahlungen berechnet werden.
            payout = 0;
            for i = 1:length(obj.reelResults)
                payout = payout + obj.payoutTable(obj.reelResults(i));
            end
            return
        end

        function obj = updatePayoutTable(obj, newTable)
            % Aktualisiert die Auszahlungstabelle, um Änderungen in den Auszahlungsregeln widerzuspiegeln.
            obj.payoutTable = newTable;
        end

        function obj = resetCalculator(obj)
            % Setzt den Rechner zurück, um für eine neue Spielrunde bereit zu sein.
            obj.reelResults = [];
        end
    end
end
