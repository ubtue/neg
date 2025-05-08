package de.uni_tuebingen.ub.nppm.util;

import java.io.IOException;
import javax.servlet.jsp.JspWriter;

/**
 * Purpose of this class is to implement a dummy JspWriter that simply
 * writes added information to a class variable instead of the default output
 * which can be queried using getBuffer().
 */
public class JspWriterStringBuffer extends JspWriter {
    String buffer = "";

    public JspWriterStringBuffer() {
        super(12345678, false);
    }

    public String getBuffer() {
        return buffer;
    }

    @Override
    public int getRemaining() {
        return bufferSize - buffer.length();
    }

    @Override
    public void clear() {
        buffer = "";
    }

    @Override
    public void clearBuffer() {
        buffer = "";
    }

    @Override
    public void close() {

    }

    @Override
    public void flush() {

    }

    @Override
    public void print(Object x) {
        buffer += x.toString();
    }

    @Override
    public void println(Object x) {
        print(x);
        println();
    }

    @Override
    public void print(String x) {
        buffer += x;
    }

    @Override
    public void println(String x) {
        print(x);
        println();
    }

    @Override
    public void print(char x) {
        buffer += x;
    }

    @Override
    public void println(char x) {
        print(x);
        println();
    }

    @Override
    public void print(char[] x) {
        buffer += x;
    }

    @Override
    public void println(char[] x) {
        print(x);
        println();
    }

    @Override
    public void print(double x) {
        buffer += x;
    }

    @Override
    public void println(double x) {
        print(x);
        println();
    }

    @Override
    public void print(float x) {
        buffer += x;
    }

    @Override
    public void println(float x) {
        print(x);
        println();
    }

    @Override
    public void print(long x) {
        buffer += x;
    }

    @Override
    public void println(long x) {
        print(x);
        println();
    }

    @Override
    public void print(int x) {
        buffer += x;
    }

    @Override
    public void println(int x) {
        print(x);
        println();
    }

    @Override
    public void print(boolean x) {
        buffer += Boolean.toString(x);
    }

    @Override
    public void println(boolean x) {
        print(x);
        println();
    }

    @Override
    public void println() {
        buffer += System.lineSeparator();
    }

    @Override
    public void newLine() {
        println();
    }

    @Override
    public void write(char[] chars, int i, int i1) throws IOException {
        for (int j = i; j <= i1; j++) {
            print(chars[j]);
        }
    }
}
