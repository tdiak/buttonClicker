gameStates = {}
gameStates.menu = 1
gameStates.play = 2
gameStates.over = 3

function love.load()
    myFont = love.graphics.newFont(40)

    button = {}
    button.x = 200
    button.y = 200
    button.size = 50

    score = 0
    timer = 10

    gameState = gameStates.menu
end


function love.update(dt)
    if timer > 0  and gameState == gameStates.play then
        timer = timer - dt
    elseif gameState == gameStates.play then
        gameState = gameStates.over
    end

end


function love.draw()
    if gameState == gameStates.play then
        love.graphics.setColor(255, 0, 0)
        love.graphics.circle("fill", button.x, button.y, button.size)
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(myFont)
        love.graphics.print(string.format("Score: %d", score), 10, 10)
        love.graphics.print(string.format("Time: %d", timer), 250, 10)
    elseif gameState == gameStates.menu then
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(myFont)
        love.graphics.printf("Click to begin !", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    elseif gameState == gameStates.over then
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(myFont)
        love.graphics.printf(string.format("Your score is: %d. Click to try once again", score), 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    end
end


function love.mousepressed(x, y, source, isTouched)
    if source == 1 and gameState == gameStates.play then
        if distanceBetween(button.x, button.y, love.mouse.getX(), love.mouse.getY()) < button.size then
            score = score + 1
            button.x = math.random(button.size, love.graphics.getWidth() - button.size)
            button.y = math.random(button.size, love.graphics.getHeight() - button.size)
        end
    end

    if gameState == gameStates.menu then
        gameState = gameStates.play
    end

    if gameState == gameStates.over then
        gameState = gameStates.play
        timer = 10
        score = 0
    end
end


function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end