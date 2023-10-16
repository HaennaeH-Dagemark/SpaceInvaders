class Bullet

    attr_reader :coords
    attr_accessor :type

    def initialize(x,version)
        @coords = {x: x + 55, y: 1080-100}
        @image = Gosu::Image.new("gfx/Lazer.png")
        @type = version
        puts ("Made new bullet")
    end

    def left
        @coords[:x]
    end

    def right 
        @coords[:x] + @image.width
    end

    def local_update()
        @coords[1] -= 10
        if @coords[1] - 50 <= 0
            @type = "dead"
        end
    end

    def draw
        @image.draw(@coords[:x], @coords[:y], 1, 0.1, 0.1)
    end
end