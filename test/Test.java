/*
 * This is a sample file.
 */
package com.intellij.samples;

import com.intellij.idea.Main;

import javax.swing.*;
import java.util.Vector;

public class Test {

    public class Foo {
        private int field1;
        private int field2;

        {
            field1 = 2;
        }

        public void foo1() {
            new Runnable() {
                public void run() {
                }
            };
        }

        public class InnerClass {
        }
    }

    class AnotherClass {
    }

    interface TestInterface {
        int MAX = 10;
        int MIN = 1;

        void method1();

        void method2();
    }

}
