package Command.oreilly.model;

import Command.oreilly.Interface.Command;

public class MarioDownCommand implements Command {
    private MarioCharacterReceiver mario;

    public MarioDownCommand(MarioCharacterReceiver mario) {
        this.mario = mario;
    }

    @Override
    public void execute() {
        mario.moveDown();
    }
}