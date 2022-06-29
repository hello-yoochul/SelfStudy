package Command.oreilly.model;

import Command.oreilly.Interface.Command;

public class Console {
    private Command upCommand;
    private Command downCommand;
    private Command leftCommand;
    private Command rightCommand;

    public Console(Command upCommand, Command downCommand, Command leftCommand, Command rightCommand) {
        this.upCommand = upCommand;
        this.downCommand = downCommand;
        this.leftCommand = leftCommand;
        this.rightCommand = rightCommand;
    }

    public void arrowUp() {
        upCommand.execute();
    }

    public void arrowLeft() {
        leftCommand.execute();
    }

    public void arrowRight() {
        rightCommand.execute();
    }

    public void arrowDown() {
        downCommand.execute();
    }
}
