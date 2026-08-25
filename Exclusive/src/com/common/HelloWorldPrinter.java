package com.common;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.print.*;


public class HelloWorldPrinter  implements Printable {
 
 
    public int print(Graphics g, PageFormat pf, int page) throws
                                                        PrinterException {
 
        if (page > 0) { /* We have only one page, and 'page' is zero-based */
            return NO_SUCH_PAGE;
        }
 
        /* User (0,0) is typically outside the imageable area, so we must
         * translate by the X and Y values in the PageFormat to avoid clipping
         */
        
        Graphics2D g2d = (Graphics2D)g;
        g2d.translate(pf.getImageableX(), pf.getImageableY());
 
        /* Now we perform our rendering */
        g.drawString("Hello world!", 100, 100);
        g.drawRect(17, 9, 17, 9);
        
        Rectangle envelope = new Rectangle(432, 252);
    //    Document pdfDoc = new Document(envelope, 10f, 10f, 100f, 0f);
        //g.drz
        /* tell the caller that this page is part of the printed document */
        return PAGE_EXISTS;
    }
 
    public void actionPerformed() {
         PrinterJob job = PrinterJob.getPrinterJob();
         job.setPrintable(this);
         boolean ok = job.printDialog();
         if (ok) {
             try {
                  job.print();
             } catch (PrinterException ex) {
             System.out.println("The job did not successfully complete");   
             }
         }
  }
 
   /* public  void main(String args[]) {
  
        UIManager.put("swing.boldMetal", Boolean.FALSE);
        JFrame f = new JFrame("Hello World Printer");
        f.addWindowListener(new WindowAdapter() {
           public void windowClosing(WindowEvent e) {System.exit(0);}
        });
        JButton printButton = new JButton("Print Hello World");
        printButton.addActionListener(new HelloWorldPrinter());
        f.add("Center", printButton);
        f.pack();
        f.setVisible(true);
    }*/
}
