classdef AnimationManager
    % AnimationManager - Verantwortlich für die Verwaltung aller Animationen im Spiel.
    %
    % Diese Klasse steuert alle grafischen Animationen innerhalb des Slot-Machine-Simulators, einschließlich
    % der Animationen für das Drehen der Walzen, das Anzeigen von Gewinnen und anderen visuellen Effekten.
    % Sie arbeitet eng mit dem UIController zusammen, um eine nahtlose visuelle Spielerfahrung zu gewährleisten.
    %
    % Eigenschaften:
    %   reelAnimations - Eine Liste von Animation-Objekten für jede Walze.
    %   winAnimation - Eine Animation, die bei einem Gewinn abgespielt wird.
    %   animationSpeed - Die Geschwindigkeit, mit der die Animationen abgespielt werden.
    %
    % Methoden:
    %   playReelSpin - Startet die Animation für das Drehen der Walzen.
    %   stopReelSpin - Stoppt die Walzenanimationen an einer bestimmten Position.
    %   displayWin - Zeigt eine Gewinnanimation an.
    %   setAnimationSpeed - Stellt die Geschwindigkeit der Animationen ein.

    properties
        reelAnimations
        winAnimation
        animationSpeed
    end

    methods
        function obj = AnimationManager(reels)
            % Konstruktor, der die Animationen initialisiert.
            obj.reelAnimations = cell(1, numel(reels));
            for i = 1:numel(reels)
                obj.reelAnimations{i} = createAnimation(reels(i));
            end
            obj.winAnimation = createWinAnimation();
            obj.animationSpeed = 1.0;  % Standardgeschwindigkeit
        end

        function playReelSpin(obj)
            % Startet die Animation für das Drehen der Walzen.
            for i = 1:numel(obj.reelAnimations)
                start(obj.reelAnimations{i}, 'Speed', obj.animationSpeed);
            end
        end

        function stopReelSpin(obj, positions)
            % Stoppt die Walzenanimationen an vorgegebenen Positionen.
            for i = 1:numel(positions)
                stopAt(obj.reelAnimations{i}, positions(i));
            end
        end

        function displayWin(obj)
            % Zeigt eine Gewinnanimation an.
            play(obj.winAnimation);
        end

        function setAnimationSpeed(obj, speed)
            % Stellt die Geschwindigkeit der Animationen ein.
            obj.animationSpeed = speed;
            for i = 1:numel(obj.reelAnimations)
                setSpeed(obj.reelAnimations{i}, speed);
            end
        end
    end

    methods (Access = private)
        function anim = createAnimation(~, ~)
            % Erstellt eine neue Animation für eine Walze.
            anim = figure; % Pseudocode für die Erstellung einer Figure
        end

        function anim = createWinAnimation(~)
            % Erstellt eine Gewinnanimation.
            anim = figure; % Pseudocode für die Erstellung einer Figure
        end
    end
end
