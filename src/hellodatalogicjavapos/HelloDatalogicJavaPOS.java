
package hellodatalogicjavapos;

import com.dls.jpos.common.DLSJposConst;
import jpos.Scanner;
import java.io.*;

/*
 * HelloDatalogicJavaPOS does a Datalogic directIO Beep on a scanner.
 * 
 * You will hear the scanner beep if everything works.
 * 1 Device attached
 * 2 Device interface and port name match your chosen
 *   jpos.xml DatalogicJavaPOSDevice entry.
 * 3 This DatalogicJavaPOSDevice entry is in the
 *   jpos.xml in the install directory
 *       C:\Program Files\Datalogic\JavaPOS
 *   or
 *       /usr/local/Datalogic/JavaPOS
 * 4 Device configured for beep and interface supports
 *   this DIO_SCANNER_DIO_BEEP command.
 */
public class HelloDatalogicJavaPOS {

    /*
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            // Hello message and question.
            System.out.println("Hello Datalogic JavaPOS.");
            System.out.println("Do you hear the scanner beep?");

            Scanner scannerObj = new Scanner();

            // The int array values are placeholders.
            // The int array is unused by the scanner directIO beep command.
            int[] intArr = new int[50];
            intArr[0] = 17;

            ByteArrayOutputStream dioResult = new ByteArrayOutputStream();

            scannerObj.open("DatalogicJavaPOSDevice");

            scannerObj.claim(1000);

            scannerObj.directIO(DLSJposConst.DIO_SCANNER_DIO_BEEP,intArr,dioResult);

            System.out.println(dioResult.toString());
            scannerObj.release();
            scannerObj.close();

            // This exit 0 status code indicates normal termination.
            System.exit(0);

        } catch (Exception exp) {
            // Print its stack trace.
            exp.printStackTrace();
            // A non-zero status code indicates abnormal termination.
            System.exit(19);
        }
    }
}
