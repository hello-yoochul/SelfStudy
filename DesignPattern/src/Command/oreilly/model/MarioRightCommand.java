package Command.oreilly.model;

import Command.oreilly.Interface.Command;

public class MarioRightCommand implements Command {
    private MarioCharacterReceiver mario;

    public MarioRightCommand(MarioCharacterReceiver mario) {
        this.mario = mario;
    }

    @Override
    public void execute() {
        mario.moveRight();
    }
}
