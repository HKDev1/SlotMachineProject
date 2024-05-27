classdef BonusManager
    % BonusManager - Verantwortlich für die Verwaltung von Bonusrunden und speziellen Spielereignissen.
    %
    % Diese Klasse steuert die Bonusfunktionen des Slot-Machine-Simulators. Sie initiiert und verwaltet Bonusrunden,
    % spezielle Ereignisse und andere spielbezogene Aktionen, die außerhalb des normalen Spielablaufs liegen.
    %
    % Eigenschaften:
    %   bonusRules - Eine Liste oder ein Struct, das die Regeln und Bedingungen für das Auslösen von Boni speichert.
    %   activeBonuses - Eine Liste aktiver Boni, die im Spiel verfügbar sind.
    %
    % Methoden:
    %   activateBonus - Aktiviert einen spezifischen Bonus.
    %   deactivateBonus - Deaktiviert einen aktiven Bonus.
    %   checkBonusConditions - Überprüft, ob die Bedingungen für Boni erfüllt sind.
    %   applyBonusEffects - Wendet die Effekte eines Bonus auf das Spiel an.

    properties
        bonusRules
        activeBonuses
    end

    methods
        function obj = BonusManager()
            % Konstruktor, der den BonusManager initialisiert und die Bonusregeln lädt.
            obj.bonusRules = loadBonusRules();
            obj.activeBonuses = {};
        end

        function activateBonus(obj, bonusId)
            % Aktiviert einen spezifischen Bonus, basierend auf einer Bonus-ID.
            % 'bonusId' identifiziert den spezifischen Bonus in den bonusRules.
            if isKey(obj.bonusRules, bonusId)
                obj.activeBonuses{end+1} = obj.bonusRules(bonusId);
                obj.applyBonusEffects(obj.bonusRules(bonusId));
            else
                error('Invalid bonus ID');
            end
        end

        function deactivateBonus(obj, bonusId)
            % Deaktiviert einen aktiven Bonus.
            idx = find(cellfun(@(b) strcmp(b.id, bonusId), obj.activeBonuses));
            if ~isempty(idx)
                obj.activeBonuses(idx) = [];
            end
        end

        function checkBonusConditions(obj, gameData)
            % Überprüft die Bedingungen für alle Boni und aktiviert sie bei Erfüllung.
            for k = keys(obj.bonusRules)
                bonus = obj.bonusRules(k{1});
                if bonus.condition(gameData)
                    obj.activateBonus(k{1});
                end
            end
        end

        function applyBonusEffects(obj, bonus)
            % Wendet die Effekte eines Bonus auf das Spiel an.
            % 'bonus' enthält die Details zum Bonus und dessen Auswirkungen.
            bonus.effect();
        end
    end

    methods (Access = private)
        function rules = loadBonusRules(obj)
            % Lädt die Regeln und Bedingungen für Boni.
            rules = containers.Map;
            % Beispiel für einen Bonus
            rules('freeSpin') = struct('id', 'freeSpin', 'condition', @(data) data.spins > 100, 'effect', @() disp('Free Spin Activated'));
        end
    end
end
