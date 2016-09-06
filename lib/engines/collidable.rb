# Collidable must have the following:
# @x, @y accessors for x-coord/y-coord respectively
# @w, @h accessors for width/height respectively
# Collidable#collide! instance method

module Engines
  module Collidable
    def collidable?
      true
    end

    # @return Nil, Engines::Collision
    def check_collision(collidable)
      w = 0.5 * (self.w + collidable.w)
      h = 0.5 * (self.h + collidable.h)
      dx = self.center_x - collidable.center_x
      dy = self.center_y - collidable.center_y

      if dx.abs <= w && dy.abs <= h
        wy = w * dy
        hx = h * dx
        if wy > hx
          if wy > -hx
            Collision.new(:top, collidable.y - self.y + collidable.h)
          else
            Collision.new(:left, (self.x - collidable.x + self.w))
          end
        else
          if wy > -hx
            Collision.new(:right, (collidable.x - self.x + collidable.w))
          else
            Collision.new(:bottom, self.y - collidable.y + self.h)
          end
        end
      end
    end

    def center_x
      x + (0.5 * w)
    end

    def center_y
      y + (0.5 * h)
    end
  end
end