package ai_bandit.lab3;

import javax.swing.*;

public class PlayThread extends Thread {
    private final Model model;
    private final JFrame frame;
    private final int waitTimeMs;
    private boolean isRun = false;
    private boolean isPlayGreedy;

    public PlayThread(Model model, JFrame frame, boolean isPlayGreedy, int waitTimeMs) {
        this.model = model;
        this.frame = frame;
        this.isPlayGreedy = isPlayGreedy;
        this.waitTimeMs = waitTimeMs;
    }

    public void terminateRun() {
        isRun = false;
    }

    @Override
    public void run() {
        isRun = true;

        while (isRun) {
            model.play(isPlayGreedy);
            frame.repaint();

            try {
                Thread.sleep(waitTimeMs);
            } catch (InterruptedException e) {
            }
        }
    }


}
