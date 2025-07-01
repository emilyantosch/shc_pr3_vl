package ai_bandit.lab3;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GraphicalUI {
    private final JFrame frame;
    private final JRadioButton radioRandom, radioEpsGreedy;
    private JButton buttonReset, buttonStep1, buttonStep10, buttonStep100, buttonStartStop;
    private final PlotBarPanel countPanel;
    private final PlotPanel moneyPanel;
    private PlayThread playThread;

    public GraphicalUI(Model model) {
        // Create frame and set properties
        frame = new JFrame("Hensel's Eleven");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationByPlatform(true);
        frame.setResizable(false);

        // Create plots and plots panel
        JPanel plotsPanel = new JPanel();
        plotsPanel.setLayout(new BoxLayout(plotsPanel, BoxLayout.Y_AXIS));
        countPanel = new PlotBarPanel("Bandit selection count", 600, 250, 20, model.getBanditSelectedCounts());
        moneyPanel = new PlotPanel("Available money", 600, 250, 20, model.getMoneyHistory());
        plotsPanel.add(countPanel);
        plotsPanel.add(moneyPanel);

        // Create control widgets and control panel
        JPanel controlPanel = new JPanel();
        JPanel buttonPanel = new JPanel();
        controlPanel.setLayout(new BoxLayout(controlPanel, BoxLayout.Y_AXIS));
        buttonPanel.setLayout(new GridLayout(20,1));

        createButtons(model);
        buttonPanel.add(new JLabel(""));
        buttonPanel.add(buttonReset);
        buttonPanel.add(buttonStep1);
        buttonPanel.add(buttonStep10);
        buttonPanel.add(buttonStep100);
        buttonPanel.add(buttonStartStop);

        radioRandom = new JRadioButton("Random bandit          ", false);
        radioEpsGreedy = new JRadioButton("Epsilon-greedy          ", true);
        ButtonGroup strategyGroup = new ButtonGroup();
        strategyGroup.add(radioRandom);
        strategyGroup.add(radioEpsGreedy);
        controlPanel.add(new Label("Selection strategy:"));
        controlPanel.add(radioRandom, Component.LEFT_ALIGNMENT);
        controlPanel.add(radioEpsGreedy, Component.LEFT_ALIGNMENT);
        controlPanel.add(buttonPanel);

        // Layout widgets
        Container contentPane = frame.getContentPane();
        contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.X_AXIS));
        contentPane.add(plotsPanel);
        contentPane.add(controlPanel);

        // Show frame
        frame.pack();
        frame.setVisible(true);
    }

    private void createButtons(Model model) {
        // Create widgets
        buttonReset = new JButton("Reset bandits");
        buttonStep1 = new JButton("Play 1x");
        buttonStep10 = new JButton("Play 10x");
        buttonStep100 = new JButton("Play 100x");
        buttonStartStop = new JButton("Start");

        // Event handling
        buttonReset.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                model.resetHistory();
                frame.repaint();
            }
        });

        buttonStep1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                boolean isPlayGreedy = radioEpsGreedy.isSelected();
                model.play(isPlayGreedy);
                frame.repaint();
            }
        });

        buttonStep10.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                boolean isPlayGreedy = radioEpsGreedy.isSelected();
                for (int i = 0; i < 10; i++) {
                    model.play(isPlayGreedy);
                }
                frame.repaint();
            }
        });

        buttonStep100.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                boolean isPlayGreedy = radioEpsGreedy.isSelected();
                for (int i = 0; i < 100; i++) {
                    model.play(isPlayGreedy);
                }
                frame.repaint();
            }
        });

        buttonStartStop.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (buttonStartStop.getText().equalsIgnoreCase("Start")) {
                    buttonStartStop.setText("Stop");
                    buttonReset.setEnabled(false);
                    buttonStep1.setEnabled(false);
                    buttonStep10.setEnabled(false);
                    buttonStep100.setEnabled(false);
                    radioRandom.setEnabled(false);
                    radioEpsGreedy.setEnabled(false);

                    playThread = new PlayThread(model, frame, radioEpsGreedy.isSelected(), 100);
                    playThread.start();
                } else {
                    buttonStartStop.setText("Start");
                    buttonReset.setEnabled(true);
                    buttonStep1.setEnabled(true);
                    buttonStep10.setEnabled(true);
                    buttonStep100.setEnabled(true);
                    radioRandom.setEnabled(true);
                    radioEpsGreedy.setEnabled(true);

                    playThread.terminateRun();
                    playThread = null;
                }
            }
        });
    }

    public void repaint() {
        frame.repaint();
    }
}

