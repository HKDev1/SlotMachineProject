classdef HistoryTracker
    % HistoryTracker - Protokolliert Spielvorgänge und -geschichte für Analysen und Rückblicke.
    %
    % Diese Klasse ist dafür verantwortlich, alle relevanten Spielereignisse und Historien zu protokollieren.
    % Sie speichert Informationen zu jedem Spielzug, Wetten, Gewinnen, Verlusten und Spielerinteraktionen, um
    % Trends zu analysieren und Berichte zu erstellen.
    %
    % Eigenschaften:
    %   gameHistory - Ein Array oder eine Tabelle, die die Chronik der Spielereignisse speichert.
    %   reportGenerator - Ein Tool zur Erzeugung von Berichten aus den gesammelten Daten.
    %
    % Methoden:
    %   logEvent - Fügt ein Ereignis zur Spielgeschichte hinzu.
    %   generateReport - Erstellt einen Bericht basierend auf der gesammelten Historie.
    %   clearHistory - Löscht die gespeicherte Historie, um Platz für neue Daten zu schaffen.

    properties
        gameHistory
    end

    methods
        function obj = HistoryTracker()
            % Konstruktor, der die HistoryTrackerinstanz initialisiert.
            obj.gameHistory = [];  % Initialisierung der Historie
        end

        function logEvent(obj, eventType, eventData)
            % Protokolliert ein Ereignis in der Spielgeschichte.
            % 'eventType' ist eine Beschreibung des Ereignistyps (z.B. 'betPlaced', 'spinResult').
            % 'eventData' enthält alle relevanten Daten des Ereignisses.
            newEntry = struct('Type', eventType, 'Data', eventData, 'Timestamp', datetime('now'));
            obj.gameHistory = [obj.gameHistory; newEntry];
        end

        function report = generateReport(obj)
            % Erstellt einen Bericht aus den gesammelten historischen Daten.
            % Hier generieren wir den Bericht direkt, anstatt eine separate ReportGenerator-Klasse zu verwenden.
            report = struct();
            for i = 1:length(obj.gameHistory)
                event = obj.gameHistory(i);
                report.(event.Type)(end+1) = event.Data;
            end
        end

        function clearHistory(obj)
            % Löscht die gespeicherte Historie.
            obj.gameHistory = [];
        end
    end
end
