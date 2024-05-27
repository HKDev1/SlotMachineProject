classdef Reel
    % Reel - Repräsentiert eine einzelne Walze in der Slot-Maschine und enthält eine Liste von Symbolen.
    %
    % Diese Klasse verwaltet die individuellen Walzen eines Slot-Machines. Jede Walze besteht aus einer Sammlung von Symbolen,
    % die beim Drehen der Walze zufällig angezeigt werden. Die Klasse steuert die Drehbewegungen und hält die Ergebnisse fest.
    %
    % Eigenschaften:
    %   symbols - Ein Array von Symbolen, die auf der Walze vorhanden sind.
    %   currentPosition - Die aktuelle Position der Walze, die angibt, welches Symbol gerade sichtbar ist.
    %   numberOfSymbols - Die Anzahl der Symbole auf der Walze.
    %
    % Methoden:
    %   spin - Startet die Drehung der Walze und ändert die currentPosition zufällig.
    %   stop - Stoppt die Walze an einer bestimmten Position, die das Ergebnis des Spins bestimmt.
    %   getCurrentSymbol - Gibt das Symbol an der currentPosition zurück.

    properties
        symbols
        currentPosition
        numberOfSymbols
    end

    methods
        function obj = Reel(symbols)
            % Konstruktor, der eine Walze mit gegebenen Symbolen initialisiert.
            obj.symbols = symbols;
            obj.numberOfSymbols = length(symbols);
            obj.currentPosition = randi(obj.numberOfSymbols);  % Startet an einer zufälligen Position
        end

        function spin(obj)
            % Startet die Drehung der Walze.
            % Die neue Position wird zufällig ausgewählt, simuliert das Drehen.
            obj.currentPosition = randi(obj.numberOfSymbols);
        end

        function stop(obj, position)
            % Stoppt die Walze an einer bestimmten Position.
            % Diese Methode wird in der Regel nach dem Spin aufgerufen, um das Ergebnis zu fixieren.
            if position <= obj.numberOfSymbols && position > 0
                obj.currentPosition = position;
            else
                error('Invalid stop position');
            end
        end

        function symbol = getCurrentSymbol(obj)
            % Gibt das aktuelle Symbol an der currentPosition zurück.
            symbol = obj.symbols(obj.currentPosition);
        end
    end
end
