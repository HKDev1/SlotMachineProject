classdef NetworkManager
    % NetworkManager - Verantwortlich für die Netzwerkkommunikation innerhalb des Slot-Machine-Simulators.
    %
    % Diese Klasse steuert alle Netzwerkoperationen, die für das Spiel notwendig sind, einschließlich der Kommunikation mit
    % Servern für die Authentifizierung von Benutzern, das Laden von Spielerprofilen, das Aktualisieren von Leaderboards und
    % das Speichern von Spielfortschritten in der Cloud.
    %
    % Eigenschaften:
    %   serverURL - Die URL des Servers, mit dem die Kommunikation erfolgt.
    %   authToken - Der Authentifizierungstoken, der für sichere Anfragen verwendet wird.
    %
    % Methoden:
    %   sendRequest - Sendet eine Anfrage an den Server und verarbeitet die Antwort.
    %   authenticateUser - Führt die Benutzerauthentifizierung durch.
    %   loadUserProfile - Lädt das Spielerprofil vom Server.
    %   updateLeaderboard - Sendet aktuelle Highscores an den Leaderboard-Server.
    %   saveGameProgress - Speichert den Spielfortschritt auf dem Server.

    properties
        serverURL
        authToken
    end

    methods
        function obj = NetworkManager(serverURL)
            % Konstruktor, der die Netzwerkmanagerinstanz initialisiert.
            obj.serverURL = serverURL;
            obj.authToken = '';
        end

        function response = sendRequest(obj, endpoint, data, method)
            % Sendet eine HTTP-Anfrage an den Server.
            % 'endpoint' ist der spezifische API-Endpunkt.
            % 'data' sind die zu sendenden Daten.
            % 'method' ist die HTTP-Methode (z.B. 'POST', 'GET').
            webOptions = weboptions('RequestMethod', method, 'HeaderFields', {'Authorization', obj.authToken});
            response = webwrite(strcat(obj.serverURL, endpoint), data, webOptions);
        end

        function authenticateUser(obj, username, password)
            % Authentifiziert einen Benutzer beim Server.
            data = struct('username', username, 'password', password);
            response = obj.sendRequest('/authenticate', data, 'POST');
            obj.authToken = response.token;
        end

        function profile = loadUserProfile(obj, userId)
            % Lädt das Spielerprofil vom Server.
            endpoint = strcat('/user/profile/', num2str(userId));
            profile = obj.sendRequest(endpoint, [], 'GET');
        end

        function updateLeaderboard(obj, score)
            % Aktualisiert den Leaderboard mit dem neuen Score des Spielers.
            data = struct('score', score);
            obj.sendRequest('/leaderboard/update', data, 'POST');
        end

        function saveGameProgress(obj, gameData)
            % Speichert den Spielfortschritt des Spielers auf dem Server.
            obj.sendRequest('/game/save', gameData, 'POST');
        end
    end
end
