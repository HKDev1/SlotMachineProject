% Hauptskript für das Book of Ra ähnliche Slot-Machine-Spiel
clear;
clc;

% Hinzufügen der Klassen zum Pfad
addpath(genpath('C:\Users\Messknecht_BS\Documents\SlotRunner'));

% Initialisierung der Spielsymbole
symbole = [ ...
    Symbol('Adventurer', 'adventurer.png', 1000), ...
    Symbol('Sphinx', 'sphinx.png', 750), ...
    Symbol('Scarab', 'scarab.png', 200), ...
    Symbol('Ace', 'ace.png', 150), ...
    Symbol('King', 'king.png', 100), ...
    Symbol('Queen', 'queen.png', 75), ...
    Symbol('Jack', 'jack.png', 50), ...
    Symbol('Ten', 'ten.png', 25) ...
];

% Erstellen der Walzen mit Symbolen
reels = [Reel(symbole), Reel(symbole), Reel(symbole), Reel(symbole), Reel(symbole)];

% Initialisieren des GameEngines mit Profil und Walzen
playerProfile = PlayerProfile('Spieler1'); % Initialisierung mit nur einem Argument
playerProfile.balance = 500; % Setzen des Anfangssaldos nach der Initialisierung
gameEngine = GameEngine(playerProfile, reels); % Modifiziert, um direkt die Walzen zu akzeptieren

% Spiellogikschleife
while playerProfile.balance > 0
    fprintf('\nAktuelles Guthaben: %d\n', playerProfile.balance);
    bet = input('Wetteinsatz eingeben (0 zum Beenden): ');
    if bet == 0
        break;
    elseif bet <= playerProfile.balance
        gameEngine.enterBet(bet);  % Wetteinsatz verarbeiten
        gameEngine.spinReels();  % Startet den Spin der Walzen
        gameEngine.stopReels();  % Stoppt die Walzen und berechnet die Gewinne
        winnings = gameEngine.calculateWinnings();  % Berechnet Gewinne
        fprintf('Gewonnen: %d\n', winnings);
        
        % Überprüfen und ausführen der Gamble-Funktion
        if winnings > 0 && input('Möchten Sie das Gamble-Feature nutzen? (1=Ja, 0=Nein): ')
            if rand() <= 0.5
                fprintf('Glückwunsch! Gewinn verdoppelt.\n');
                playerProfile.updateBalance(winnings);  % Verdoppelt den Gewinn
            else
                fprintf('Leider verloren!\n');
                playerProfile.updateBalance(-winnings);  % Verliert den Gewinn
            end
        end
    else
        fprintf('Ungültige Wette. Nicht genug Guthaben.\n');
    end
end

fprintf('Spiel beendet. Endguthaben: %d\n', playerProfile.balance);
