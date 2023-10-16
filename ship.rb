class Ship
    attr_accessor :coords

    def initialize(x, y)
        @coords = {x: x, y: y}
        @image = Gosu::Image.new("gfx/ship1.png")
        @type = "default"
    end

    def middle
        @coords[:x] + (@image.width / 2)
    end

    def local_update()
        if Gosu::button_down?(Gosu::KbA)
            if @coords[:x] - 10 > 0
                @coords[:x] -= 10
            end
        end
        if Gosu::button_down?(Gosu::KbD)
            if @coords[:x] + 10 < 1920
                @coords[:x] += 10
            end
        end
        if Gosu::button_down?(Gosu::KbSpace)
            if @cooldowns[0] == 0
                @bullets << Bullet.new(@coords[0], @bulletType)
                @cooldowns[0] = 0.5
            else
                puts("Cooldown not done, wait #{@cooldowns[0]}")
            end
        end
    end

    def draw
        @image.draw(@coords[:x], @coords[:y], 1, 1, 1)
    end
end