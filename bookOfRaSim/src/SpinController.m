classdef SpinController
    % SpinController - Verantwortlich für das Starten, Stoppen und Verwalten der Drehungen der Walzen.
    %
    % Diese Klasse steuert das Drehen der Walzen in einem Slot-Machine-Simulator. Sie initiiert den
    % Start und das Stoppen der Walzen und sorgt für die Einhaltung der Spielregeln bezüglich der
    % Drehgeschwindigkeit und der Dauer der Drehungen.
    %
    % Eigenschaften:
    %   reels - Eine Referenz auf die Liste der Walzen, die vom GameEngine gesteuert werden.
    %   isSpinning - Ein boolescher Wert, der den Drehzustand aller Walzen angibt.
    %   spinDuration - Die Dauer, wie lange die Walzen sich drehen sollen.
    %
    % Methoden:
    %   startSpin - Startet die Drehung aller Walzen.
    %   stopSpin - Stoppt alle Walzen, oft basierend auf Zufallspositionen.
    %   manageSpin - Überwacht den Zustand der Drehung und steuert Übergänge und Timing.

    properties
        reels
        isSpinning
        spinDuration
    end

    methods
        function obj = SpinController(reels)
            % Konstruktor, der die Walzen initialisiert und Standardwerte für die Drehung festlegt.
            obj.reels = reels;
            obj.isSpinning = false;
            obj.spinDuration = 3000; % Standarddrehzeit in Millisekunden
        end

        function startSpin(obj)
            % Startet die Drehung der Walzen.
            obj.isSpinning = true;
            for i = 1:numel(obj.reels)
                obj.reels(i).spin();
            end
        end

        function stopSpin(obj)
            % Stoppt alle Walzen nach einer zufälligen oder vorbestimmten Position.
            obj.isSpinning = false;
            for i = 1:numel(obj.reels)
                position = randi(length(obj.reels(i).symbols)); % Zufällige Stopposition
                obj.reels(i).stop(position);
            end
        end

        function manageSpin(obj)
            % Verwaltet aktive Drehungen, überprüft Drehzeiten und steuert Stopps.
            if obj.isSpinning
                % Überprüft, ob die Drehzeit abgelaufen ist
                pause(obj.spinDuration / 1000); % Pause in Sekunden
                obj.stopSpin();
            end
        end
    end
end
