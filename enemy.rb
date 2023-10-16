class Enemy 

    attr_writer :dir, :movement_oppertunity
    attr_accessor :type, :coords

    def initialize(x, y, version)
        @coords = {x: x, y: y}
        @type = version
        @dir = 1
        @movement_oppertunity = false
    end

    def local_update()
        if @movement_oppertunity == true
            @coords[0] += 100 * @dir
            @movement_oppertunity = false
        end
        if @type == "dead"
            puts("Oh damn i'm dead")
        end
    end

    def draw
        Gosu.draw_rect(coords[:x], coords[:y], 100, 100, Gosu::Color.argb(0xff_00ffff))
    end
end