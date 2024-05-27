classdef Symbol
    % Symbol - Repräsentiert ein einzelnes Symbol auf einer Walze in der Slot-Maschine.
    %
    % Diese Klasse definiert die Eigenschaften eines Symbols, das in einem Slot-Machine-Spiel verwendet wird.
    % Jedes Symbol kann einen eigenen Wert und ein eigenes Aussehen haben, welches für die Spiellogik und die
    % visuelle Darstellung wichtig ist.
    %
    % Eigenschaften:
    %   icon - Das Bild oder Symbol, das visuell dargestellt wird.
    %   value - Der Wert des Symbols, der bei der Auszahlungsberechnung verwendet wird.
    %   name - Der Name des Symbols, der zur Identifikation in Spiellogiken verwendet wird.
    %
    % Methoden:
    %   display - Zeigt das Symbol an der Benutzeroberfläche an.
    %   getValue - Gibt den Wert des Symbols zurück.

    properties
        icon
        value
        name
    end

    methods
        function obj = Symbol(name, icon, value)
            % Konstruktor, der ein Symbol mit einem Namen, einem Bild und einem Wert initialisiert.
            obj.name = name;
            obj.icon = icon;
            obj.value = value;
        end

        function display(obj)
            % Zeigt das Symbol an der Benutzeroberfläche an.
            % Diese Methode könnte implementieren, wie das Bild auf der UI basierend auf 'icon' angezeigt wird.
        end

        function val = getValue(obj)
            % Gibt den Wert des Symbols zurück.
            val = obj.value;
        end
    end
end
