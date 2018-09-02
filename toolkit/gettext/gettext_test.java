package com.qingsb.gettext;

import gnu.gettext.GettextResource;

import java.util.Locale;
import java.util.ResourceBundle;

/**
 * Created by LONG on 2017/3/13.
 */
public class Translation {
    private ResourceBundle bundle;

    private Translation() {
    }

    public static Translation init(Locale locale) {
        ResourceBundle bundle = ResourceBundle.getBundle("Messages", locale);
        Translation t = new Translation();
        t.setBundle(bundle);
        return t;
    }

    public String __(String msgid) {
        return GettextResource.gettext(bundle, msgid);
    }

    public String _x(String msgid, String msgctxt) {
        return GettextResource.pgettext(bundle, msgctxt, msgid);
    }

    public String _n(String msgid, String msgid_plural, long n) {
        return GettextResource.ngettext(bundle, msgid, msgid_plural, n);
    }

    public String _nx(String msgid, String plural, long n, String context) {
        return GettextResource.npgettext(bundle, context, msgid, plural, n);
    }

    public ResourceBundle getBundle() {
        return bundle;
    }

    public void setBundle(ResourceBundle bundle) {
        this.bundle = bundle;
    }

    private static final void translate(Translation tool){
        //普通翻译
        System.out.println(tool.__("Hello"));

        //上下文翻译
        System.out.println(tool._x("post","a post"));
        System.out.println(tool._x("post","to post"));

        //单复数翻译
        System.out.printf(tool._n("%d comment\n", "%d comments\n", 1), 1);
        System.out.printf(tool._n("%d comment\n", "%d comments\n", 2), 2);

        //上下文相关的单复数翻译
        System.out.printf(tool._nx("%d comment\n", "%d comments\n", 1, "another context"), 1);
        System.out.printf(tool._nx("%d comment\n", "%d comments\n", 2, "another context"), 2);

    }
    public static void main(String[] args) {
        //中文环境
        Translation tool1=Translation.init(new Locale("zh","CN"));
        translate(tool1);
        System.out.println("------------------------------------------------");
        //英文环境
        Translation tool2=Translation.init(new Locale("en","US"));
        translate(tool2);
    }
}

