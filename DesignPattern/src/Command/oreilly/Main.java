package Command.oreilly;

import Command.oreilly.model.*;

/**
 * 커맨드 패턴이란? (Behaviour Pattern)
 * 요청을 홀로 처리할 수 있도록 요청을 수행하는 여러 인자를 함께 패키징하여
 * 나중에 처리할 수 있도록 만들어주는 행동 중심 디자인 패턴입니다.
 * <p>
 * 예제 설명
 * 상하좌우 방향키 버튼이 있는 게임기 콘솔에 다가 상하좌우 명령 객체들을 넣어주고
 * 콘솔이 클릭되면, 해당 방향 객체의 명령을 실행한다.
 * <p>
 * MarioCharacterReceiver는 캐릭터가 바뀔때마다, 다른 리시버로 교체가능하다.
 */
public class Main {
    public static void main(String[] args) {
        MarioCharacterReceiver mario = new MarioCharacterReceiver();

        MarioUpCommand marioUpCommand = new MarioUpCommand(mario);
        MarioDownCommand marioDownCommand = new MarioDownCommand(mario);
        MarioLeftCommand marioLeftCommand = new MarioLeftCommand(mario);
        MarioRightCommand marioRightCommand = new MarioRightCommand(mario);

        Console console = new Console(marioUpCommand, marioDownCommand, marioLeftCommand, marioRightCommand);

        console.arrowUp();
        console.arrowDown();
        console.arrowLeft();
        console.arrowRight();
    }
}
