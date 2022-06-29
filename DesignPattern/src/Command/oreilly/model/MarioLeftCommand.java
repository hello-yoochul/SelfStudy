package Command.oreilly.model;

import Command.oreilly.Interface.Command;

public class MarioLeftCommand implements Command {
    private MarioCharacterReceiver mario;

    public MarioLeftCommand(MarioCharacterReceiver mario) {
        this.mario = mario;
    }

    @Override
    public void execute() {
        mario.moveLeft();
    }
}