/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package nomnom;

import java.util.regex.Pattern;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import java.util.regex.Pattern;
import javax.swing.JOptionPane;
import oru.inf.InfDB;
import oru.inf.InfException;

/**
 *
 *
 * @author linodeluca
 */
public class Validering {
    //Datum
    public static boolean valideringDatum(String date) {
        if (date == null || date.isEmpty()) {
            return false;
        }

        // Ange det förväntade datumformatet
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        try {
            // Försök att parsa datumet
            LocalDate.parse(date, formatter);
            return true;
        } catch (DateTimeParseException e) {
            // Ogiltigt datumformat eller ogiltigt datum
            return false;
        }
    }

    // Kontrollerar att ett fält inte är tomt
    public static boolean faltInteTomt(String input) {
        return input != null && !input.trim().isEmpty();
    }

    //Kontrollerar endast siffror
    public static boolean arEndastSiffror(String input) {
        return input.trim().matches("\\d+");
    }

    public static boolean arGiltigtDouble(String input) {
        return input.matches("^\\d+(\\.\\d+)?$");
    }
 
    public static boolean arGiltigtInteger(String input) {
        return input.matches("^\\d+$");
    }
    // Kontrollerar att input endast innehåller bokstäver (inkl. svenska tecken)
    public static boolean arEndastBokstaver(String input) {
        return input.trim().matches("^[a-zA-ZåäöÅÄÖ]+$");
    }
}
