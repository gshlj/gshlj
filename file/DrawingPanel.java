package Future;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.util.ArrayList;
import java.util.List;

public class DrawingPanel extends JFrame {
    private List<Point> points = new ArrayList<>();
    private boolean drawing = false;

    public DrawingPanel() {
        setTitle("Drawing Panel");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel panel = new JPanel();
        JButton clearButton = new JButton("Clear");
        JButton outputButton = new JButton("Output Points");
        JLabel coordinatesLabel = new JLabel("Coordinates: ");

        panel.add(clearButton);
        panel.add(outputButton);
        panel.add(coordinatesLabel);

        DrawingCanvas canvas = new DrawingCanvas(points, coordinatesLabel);
        canvas.setBackground(Color.white);

        clearButton.addActionListener(e -> {
            points.clear();
            canvas.repaint();
        });

        outputButton.addActionListener(e -> {
            if (!points.isEmpty()) {
                for (Point point : points) {
                    System.out.println("Point: (" + point.x + ", " + point.y + ")");
                }
            } else {
                System.out.println("No points to output.");
            }
        });

        canvas.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                drawing = true;
                points.clear();
                points.add(e.getPoint());
            }

            @Override
            public void mouseReleased(MouseEvent e) {
                drawing = false;
                canvas.repaint();
            }
        });

        canvas.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseDragged(MouseEvent e) {
                if (drawing) {
                    points.add(e.getPoint());
                    canvas.repaint();
                }
            }
        });

        getContentPane().setLayout(new BorderLayout());
        getContentPane().add(panel, BorderLayout.NORTH);
        getContentPane().add(canvas, BorderLayout.CENTER);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            DrawingPanel drawingPanel = new DrawingPanel();
            drawingPanel.setVisible(true);
        });
    }
}

class DrawingCanvas extends JPanel {
    private List<Point> points;
    private JLabel coordinatesLabel;

    public DrawingCanvas(List<Point> points, JLabel coordinatesLabel) {
        this.points = points;
        this.coordinatesLabel = coordinatesLabel;
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        if (!points.isEmpty()) {
            drawCurve(g);
        }
        drawMouseCoordinates(g);
    }

    private void drawCurve(Graphics g) {
        Graphics2D g2d = (Graphics2D) g;
        g2d.setColor(Color.black);
        g2d.setStroke(new BasicStroke(2));

        Point p1 = points.get(0);
        for (int i = 1; i < points.size(); i++) {
            Point p2 = points.get(i);
            g2d.drawLine(p1.x, p1.y, p2.x, p2.y);
            p1 = p2;
        }
    }

    private void drawMouseCoordinates(Graphics g) {
        Point mousePoint = getMousePosition();
        if (mousePoint != null) {
            coordinatesLabel.setText("Coordinates: (" + mousePoint.x + ", " + mousePoint.y + ")");
        }
    }
}
