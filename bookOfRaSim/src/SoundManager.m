classdef SoundManager
    % SoundManager - Verantwortlich für die Verwaltung von Audioeffekten und Musik im Spiel.
    %
    % Diese Klasse steuert alle Audioelemente innerhalb des Slot-Machine-Simulators. Sie verwaltet die
    % Soundeffekte für Ereignisse wie das Drehen der Walzen, Gewinne und andere spielbezogene Aktivitäten.
    % Zudem kann sie Hintergrundmusik abspielen und steuern.
    %
    % Eigenschaften:
    %   soundEffects - Ein Container oder Dictionary, das Soundeffekte für spezifische Spielaktionen speichert.
    %   backgroundMusic - Ein Audioobjekt, das die Hintergrundmusik für das Spiel verwaltet.
    %   volume - Die Lautstärke der gesamten Audioausgabe.
    %
    % Methoden:
    %   playSound - Spielt einen bestimmten Soundeffekt ab.
    %   playMusic - Startet die Wiedergabe der Hintergrundmusik.
    %   stopMusic - Stoppt die Wiedergabe der Hintergrundmusik.
    %   setVolume - Stellt die Lautstärke ein.
    %   toggleMute - Schaltet den Ton stumm oder aktiviert ihn wieder.

    properties
        soundEffects
        backgroundMusic
        volume
    end

    methods
        function obj = SoundManager()
            % Konstruktor, der die Soundmanagerinstanz initialisiert und Sounds lädt.
            obj.soundEffects = loadSoundEffects();
            obj.backgroundMusic = loadBackgroundMusic();
            obj.volume = 1.0;  % Standardlautstärke
        end

        function playSound(obj, soundName)
            % Spielt einen bestimmten Soundeffekt ab.
            % 'soundName' ist der Schlüssel zum Zugriff auf den spezifischen Sound im Container.
            if isKey(obj.soundEffects, soundName)
                play(obj.soundEffects(soundName));
            end
        end

        function playMusic(obj)
            % Startet die Wiedergabe der Hintergrundmusik.
            play(obj.backgroundMusic);
        end

        function stopMusic(obj)
            % Stoppt die Wiedergabe der Hintergrundmusik.
            stop(obj.backgroundMusic);
        end

        function setVolume(obj, newVolume)
            % Stellt die Lautstärke der gesamten Audioausgabe ein.
            obj.volume = newVolume;
            updateVolume(obj.soundEffects, newVolume);
            setVolume(obj.backgroundMusic, newVolume);
        end

        function toggleMute(obj)
            % Schaltet den Ton stumm oder aktiviert ihn wieder.
            if obj.volume > 0
                obj.volume = 0;
            else
                obj.volume = 1;
            end
            setVolume(obj, obj.volume);
        end
    end

    methods (Access = private)
        function effects = loadSoundEffects()
            % Lädt Soundeffekte.
            effects = containers.Map;
            % Hier Soundeffekte laden und zum Map hinzufügen
        end

        function music = loadBackgroundMusic()
            % Lädt die Hintergrundmusik.
            music = audioPlayer; % Pseudocode für das Erstellen eines Audio-Players
        end
    end
end
