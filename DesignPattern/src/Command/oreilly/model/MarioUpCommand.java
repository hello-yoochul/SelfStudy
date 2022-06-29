package Command.oreilly.model;

import Command.oreilly.Interface.Command;

public class MarioUpCommand implements Command {
    private MarioCharacterReceiver mario;

    public MarioUpCommand(MarioCharacterReceiver mario) {
        this.mario = mario;
    }

    @Override
    public void execute() {
        mario.moveUp();
    }
}