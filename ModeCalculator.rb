# Chromatic Scale In The Key Of C
C_SCALE = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

# Mode Intervals
MAJOR_MODES = { 'Ionian' => '02212221', 'Dorian' => '02122212', 'Phrygian' => '01222122', 'Lydian' => '02221221', 'Mixolydian' => '02212212', 'Aeolian' => '02122122', 'Locrian' => '01221222' }
MINOR_MODES = { 'Aeolian' => '02122122', 'Locrian' => '01221222', 'Ionian' => '02212221', 'Dorian' => '02122212', 'Phrygian' => '01222122', 'Lydian' => '02221221', 'Mixolydian' => '02212212' }

def generate_fretboard(strings, frets, key, major, mode)

    result = ''
    
    intervals = major ? MAJOR_MODES[mode].chars.map(&:to_i) : MINOR_MODES[mode].chars.map(&:to_i)

    scale = C_SCALE.rotate(C_SCALE.index(key))
    p "#{key} Chromatic Scale: #{scale.join ', '}"

    $n = 0
    semitones = intervals.map { |v| $n += v; scale[$n] }.first 7
    p "Semitones In #{mode} #{major ? 'Major' : 'Minor'}: #{semitones.join ', '}"

    
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

puts generate_fretboard 'AEADGBE', 24, 'A', true, 'Ionian'
