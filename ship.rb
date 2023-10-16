
class Ship
    attr_accessor :coords, :cooldown

    def initialize(x, y, game)
        @coords = {x: x, y: y}
        @image = Gosu::Image.new("gfx/ship1.png")
        @type = "default"
        @cooldown = 0
        @game = game
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
            if @cooldown < 0
                @game.new_bullet(@coords[:x])
                @cooldown = 0.5
            else
                puts("Cooldown not done, wait #{@cooldown}")
            end
        end
    end

    def draw
        @image.draw(@coords[:x], @coords[:y], 1, 1, 1)
    end
end