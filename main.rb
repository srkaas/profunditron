# A program that randomly generates wise statements, according to what I think amounts to a context-free grammar.
# With a different data file, it could be made to generate statements that aren't wise.
# TO DO: consider fixing how it handles capitalization.

require 'yaml'
DATA = YAML.load_file('data.yaml')
MAX_EXPANSION_LEVEL = 10 # Prevent accidental infinite loops.

# Nugget of wisdom.
class Wisdom < String
  def initialize(template_string)
    super(template_string)
    expand_fully
  end

  # Are all the bracketed terms expanded?
  def expanded?
    match(/\[(.*?)\]/).nil?
  end

  # Expand all the bracketed terms once, replacing them by a random choice from the corresponding list in the data file.
  def expand
    gsub!(/\[(.*?)\]/) do |term|
      if DATA.key?($1)
        DATA[$1].sample
      else
        'ERROR: NO RULES FOUND FOR THE TERM QUOTE ' + $1 + ' UNQUOTE. WRITE SOME RULES FOR THAT TERM OR REMOVE IT.'
      end
    end
  end

  # Expand until all the brackets are gone.
  def expand_fully
    expansion_level = 0
    while !expanded? && expansion_level < MAX_EXPANSION_LEVEL
      expansion_level += 1
      expand
    end
  end
end

# Generate a nugget of wisdom.
def test_me
  puts Wisdom.new('[Initial]')
end

test_me