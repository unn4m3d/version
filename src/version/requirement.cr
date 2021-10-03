require "semantic_version"

module Version
    enum Operator
        Equal
        NotEqual
        Less
        LessOrEqual
        Greater
        GreaterOrEqual
        Approximate
        Any
    end


    class Requirement
        property version : SemanticVersion = SemanticVersion.parse("0.0.0")
        property operator : Operator = Operator::Any

        def initialize(@version, @operator)
        end

        def initialize
        end

        def self.parse(str : String) : self
            case str.chomp
            when "*", ""
                self.new SemanticVersion.new(0,0,0), Operator::Any
            else 
                if match = str.chomp.match /^(=|!=|>|>=|<|<=|~>)?\s*([^!=<>~\s]*)$/
                    operator_string = match.captures[0]
                    version = SemanticVersion.parse match.captures[1].not_nil!

                    operator = case operator_string
                    when "=", nil
                        Operator::Equal
                    when "!="
                        Operator::NotEqual
                    when "<"
                        Operator::Less
                    when "<="
                        Operator::LessOrEqual
                    when ">"
                        Operator::Greater
                    when ">="
                        Operator::GreaterOrEqual
                    when "~>"
                        Operator::Approximate
                    else
                        raise "Invalid operator #{operator_string}"
                    end

                    self.new version, operator
                else
                    raise "Invalid version requirement : #{str}"
                end
            end
        end

        def matches?(semver : SemanticVersion)
            case @operator
            when .any?
                true
            when .equal?
                semver == @version
            when .not_equal?
                semver != @version
            when .less?
                semver < @version
            when .less_or_equal?
                semver <= @version
            when .greater?
                semver > @version
            when .greater_or_equal?
                semver >= @version
            else
                upper_semver = SemanticVersion.new(@version.major, @version.minor + 1, 0)
                semver >= @version && semver < upper_semver
            end
        end

        def matches?(str : String)
            matches? SemanticVersion.parse str
        end
    end
end