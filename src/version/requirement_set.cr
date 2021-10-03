require "./requirement"

module Version
    class RequirementSet
        property requirements : Array(Requirement)

        def initialize(@requirements)
        end

        def self.parse(str : String)
            new str.split(/\s*,\s*/).map{ |x| Requirement.parse x }
        end

        def matches?(semver : SemanticVersion)
            @requirements.empty? || @requirements.all?(&.matches?(semver))
        end

        def matches?(semver : String)
            matches? SemanticVersion.parse semver
        end
    end
end