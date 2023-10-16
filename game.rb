require 'gosu'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'ship'

class Game < Gosu::Window


    def initialize
        super(1920, 1080, fullscreen = true)
        self.caption = "Space invaders"
        @laser_image = Gosu::Image.new("gfx/Lazer.png")
        @bullets = []
        @enemies = []
        @cooldowns = [0.to_f, 0.to_f] #Cooldowns for various objects. Slot 0 is the main gun, slot 2 is for enemy movement
        @time_comparison = Time.now.to_f
        puts("Created Screen")
        @state = 0
        @difficulty = 1
        @font = Gosu::Font.new(100, {name: "comic", italic: true, underline: true})
        new_wave()
        @player = Ship.new(1920/2-100, 1080-120)
    end

    def new_wave
        pos = {}
        for x in 1..12 do
            pos[0] = 110 * x - 111
            if @difficulty > 1
                pos[1] = 2 + 100 * (x/12).to_i
            end 
            pos[1] = 2
            
            @enemies << Enemy.new(pos[0], pos[1], "none")
        end
    end

    def update
        if @state == 1
            @player.local_update()
            for bullet in @bullets
                bullet.local_update()
            end 

            for enemy in @enemies
                enemy_coords = enemy.coords
                for bullet in @bullets
                    bullet_coords = bullet.coords
                    if enemy_coords[:y] + 100 >= bullet_coords[:y]
                        if bullet_coords[:x] > enemy_coords[:x] - 50 && bullet_coords[:x] < enemy_coords[:x] + 50
                            enemy.type = "dead"
                            bullet.type = "dead"
                            print("Target shot.\nBullet coords: #{bullet_coords[0]},#{bullet_coords[1]}\nEnemy coords: #{enemy_coords[0]},#{enemy_coords[1]}")
                        end
                    end
                end
                if enemy.type != "dead"
                    enemy.local_update()
                    if enemy_coords[0] > 1820
                        enemy.dir = -1
                        enemy.coords[0] -= 100
                        enemy.coords[1] += 100
                    elsif enemy_coords[0] < 0
                        enemy.dir = 1
                        enemy.coords[0] += 100
                        enemy.coords[1] += 100
                    end
                    if @cooldowns[1] == 0
                        enemy.movement_oppertunity = true
                    end
                end
            end
            if @cooldowns[1] == 0
                @cooldowns[1] = 5
            end
            @enemies.delete_if {|enemy| enemy.type == "dead"}   
            @bullets.delete_if {|enemy| enemy.type == "dead"}
            
            for x in 0..1
                if @cooldowns[x] > 0
                    delta = Time.now - @time_comparison
                    @cooldowns[x] -= delta.to_f
                elsif @cooldowns[x] < 0 
                    @cooldowns[x] = 0
                end
            end
            @time_comparison = Time.now

            c = 0
            for enemy in @enemies
                c += 1
            end
            if c == 0
                @state = 2
            end

        elsif @state == 0
            if button_down?(Gosu::KbSpace)
                @state = 1
            end
        elsif @state == 2
            if button_down?(Gosu::KbSpace)
                @difficulty += 1
                new_wave()
                @state = 1
            end
        end
    end

    def draw
        if @state == 1
            @player.draw()
            for bullet in @bullets
                bullet.draw()
            end
            for enemy in @enemies
                enemy.draw
            end
        elsif @state == 0
            @font.draw("Press Space to Start", 1000, 500, 1, 1.0, 1.0, Gosu::Color::WHITE)
        elsif @state == 2
            @font.draw("Congrats, you won! Press Space to go to the next level", 1000, 500, 1, 1.0, 1.0, Gosu::Color::WHITE)
        end
    end
end

game = Game.new
game.show   

