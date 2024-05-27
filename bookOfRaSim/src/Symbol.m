classdef Symbol
    % Symbol - Repräsentiert ein einzelnes Symbol auf einer Walze in der Slot-Maschine.
    %
    % Diese Klasse definiert die Eigenschaften und Methoden für ein Symbol, das in einem Slot-Machine-Spiel verwendet wird.
    % Jedes Symbol hat einen Namen, ein Symbolbild, einen Wert und möglicherweise andere Eigenschaften, wie z.B. ob
    % es ein Wild- oder Scatter-Symbol ist.
    %
    % Eigenschaften:
    %   name - Der Name des Symbols zur Identifikation.
    %   icon - Die visuelle Darstellung des Symbols.
    %   value - Der Basiswert des Symbols, der zur Berechnung der Auszahlungen verwendet wird.
    %   isWild - Boolean, der angibt, ob das Symbol ein Wild-Symbol ist.
    %   isScatter - Boolean, der angibt, ob das Symbol ein Scatter-Symbol ist.
    %
    % Methoden:
    %   display - Zeigt das Symbol in der Benutzeroberfläche an.
    %   getValue - Gibt den Wert des Symbols zurück.
    %   isSpecial - Gibt true zurück, wenn das Symbol ein Wild- oder Scatter-Symbol ist.
    %   static getAllSymbols - Gibt eine Liste aller Symbole des Spiels zurück.

    properties
        name
        icon
        value
        isWild
        isScatter
    end

    methods
        function obj = Symbol(name, icon, value, isWild, isScatter)
            % Konstruktor zur Initialisierung eines Symbols mit Namen, Symbolbild, Wert und speziellen Eigenschaften.
            obj.name = name;
            obj.icon = fullfile('images', icon);
            obj.value = value;
            obj.isWild = isWild;
            obj.isScatter = isScatter;
        end

        function display(obj)
            % Zeigt das Symbol in der Benutzeroberfläche an.
            % Diese Methode kann implementiert werden, um das Symbolbild in der Spiel-UI anzuzeigen.
            fprintf('Zeige Symbol an: %s\n', obj.name);
        end

        function val = getValue(obj)
            % Gibt den Wert des Symbols zurück.
            val = obj.value;
        end

        function special = isSpecial(obj)
            % Gibt true zurück, wenn das Symbol ein Wild- oder Scatter-Symbol ist.
            special = obj.isWild || obj.isScatter;
        end
    end

    methods (Static)
        function symbols = getAllSymbols()
            % Gibt eine Liste aller im Spiel verwendeten Symbole zurück.
            symbols = [
                Symbol('Explorer', 'explorer_icon.png', 1000, false, false), ...
                Symbol('Book', 'book_icon.png', 500, true, true), ... % Buch ist sowohl Wild- als auch Scatter-Symbol
                Symbol('Pharaoh', 'pharaoh_icon.png', 500, false, false), ...
                Symbol('Statue', 'statue_icon.png', 200, false, false), ...
                Symbol('Acarab', 'scarab_icon.png', 200, false, false), ...
                Symbol('Ass', 'ace_icon.png', 100, false, false), ...
                Symbol('King', 'king_icon.png', 100, false, false), ...
                Symbol('Queen', 'queen_icon.png', 50, false, false), ...
                Symbol('Jack', 'jack_icon.png', 50, false, false), ...
                Symbol('Ten', 'ten_icon.png', 50, false, false)
            ];
        end
    end
end
