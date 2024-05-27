classdef EventManager
    % EventManager - Zentrale Komponente für das Event-Management, die alle Spielereignisse wie Spin-Starts, Gewinne oder Interaktionen des Spielers handhabt.
    %
    % Diese Klasse ist verantwortlich für die Verwaltung und Verteilung aller Ereignisse im Spiel. Sie empfängt Signale von anderen Komponenten und leitet diese
    % entsprechend weiter, um Aktionen auszulösen oder den Status des Spiels zu aktualisieren.
    %
    % Eigenschaften:
    %   listeners - Eine Liste von Listenern, die auf Ereignisse reagieren.
    %   eventQueue - Eine Warteschlange für Ereignisse, die verarbeitet werden müssen.
    %
    % Methoden:
    %   subscribe - Registriert einen neuen Listener für ein bestimmtes Ereignis.
    %   unsubscribe - Entfernt einen Listener von der Abonnementliste.
    %   triggerEvent - Löst ein Ereignis aus und benachrichtigt alle entsprechenden Listener.
    %   processEvents - Verarbeitet anstehende Ereignisse aus der Warteschlange.

    properties
        listeners
        eventQueue
    end

    methods
        function obj = EventManager()
            % Konstruktor, der die EventManagerinstanz initialisiert.
            obj.listeners = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.eventQueue = {};
        end

        function subscribe(obj, eventName, callback)
            % Fügt einen Listener für ein spezifisches Ereignis hinzu.
            if isKey(obj.listeners, eventName)
                obj.listeners(eventName) = [obj.listeners(eventName), callback];
            else
                obj.listeners(eventName) = {callback};
            end
        end

        function unsubscribe(obj, eventName, callback)
            % Entfernt einen Listener für ein spezifisches Ereignis.
            if isKey(obj.listeners, eventName)
                idx = find(cellfun(@(x) isequal(x, callback), obj.listeners(eventName)));
                if ~isempty(idx)
                    remove(obj.listeners(eventName), idx);
                end
            end
        end

        function triggerEvent(obj, eventName, eventData)
            % Löst ein Ereignis aus und benachrichtigt alle registrierten Listener.
            if isKey(obj.listeners, eventName)
                cellfun(@(callback) callback(eventData), obj.listeners(eventName));
            end
        end

        function processEvents(obj)
            % Verarbeitet Ereignisse, die in der Warteschlange stehen.
            while ~isempty(obj.eventQueue)
                event = obj.eventQueue{1};
                obj.eventQueue(1) = [];  % Entfernt das bearbeitete Ereignis
                obj.triggerEvent(event.name, event.data);
            end
        end
    end
end