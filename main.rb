# A program that randomly generates wise statements, implementing what I think amounts to a context-free grammar.
# With a different data file, it could be made to generate statements that aren't wise.
# TO DO: consider fixing how it handles capitalization.

require 'yaml'
DATA = YAML.load_file('data.yaml')
MAX_EXPANSION_LEVEL = 100 # Prevent accidental infinite loops.

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
    gsub!(/\[(.*?)\]/) { |term| DATA[$1].sample }
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