require 'optparse'

# Chromatic Scale In The Key Of C
C_SCALE = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

# Mode Intervals
MODES = { 'Ionian' => '02212221', 'Dorian' => '02122212', 'Phrygian' => '01222122', 'Lydian' => '02221221', 'Mixolydian' => '02212212', 'Aeolian' => '02122122', 'Locrian' => '01221222' }

def generate_fretboard(strings, frets, key, mode)

    result = ''
    
    intervals = MODES[mode].chars.map(&:to_i)

    scale = C_SCALE.rotate(C_SCALE.index(key))
    p "#{key} Chromatic Scale: #{scale.join ', '}"

    $n = 0
    semitones = intervals.map { |v| $n += v; scale[$n] }.first 7
    p "Semitones In #{key} #{mode}: #{semitones.join ', '}"

    
    strings.chars.reverse.each do |s|
        
        scale = C_SCALE.rotate(C_SCALE.index(s))

        result += "#{s}| "

        $f = 0 
        until $f > frets do
            semi = scale[$f < 12 ? $f : $f % 12]
            result += (semitones.include? semi) ? $f.to_s.ljust(4, '-') : '-' * 4
            $f += 1
            break if $f > frets
        end

        result += "\n"
    end

    result
end

options = {}
OptionParser.new do |opts|
    opts.banner = 'OPTIONS ARE REQUIRED' 

    opts.on('-t TUNING', '--tuning=TUNING', String, 'String Tuning ( eg. EADGBE )') do |v| options[:strings] = v end
    opts.on('-f FRETS', '--frets=FRETS', Integer, 'Number Of Frets ( eg. 24 )') do |v| options[:frets] = v end
    opts.on('-k KEY', '--key=KEY', String, 'Desired Key ( eg. G# )') do |v| options[:key] = v end
    opts.on('-m MODE', '--mode=MODE', String, 'Desired Mode ( Ionian, Aeolian, Phrygian, Dorian, Lydian, Mixolydian, Locrian )') do |v| options[:mode] = v end
end.parse!

puts generate_fretboard options[:strings], options[:frets], options[:key], options[:mode]
