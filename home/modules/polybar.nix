{ pkgs, ... }: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
      pulseSupport = true;
      nlSupport = false;
      iwSupport = true;
      mpdSupport = true;
      githubSupport = true;
    };
    config = rec {
      "colors" = {
        background = "#00122A";
        background-alt = "#17374A";
        foreground = "#F0BC8D";
        foreground-alt = "#F0BC8D";
        alert = "#A43C0F";
      };

      "bar/top" = rec {
        monitor = "\${env:MONITOR:eDP-1}";
        width = "100%";
        height = 35;
        radius = 0;

        background = colors.background;
        foreground = colors.foreground;

        font-size = "10";

        font-0 = "Hack:style=Regular:size=${font-size};5";
        font-1 = "Font Awesome 5 Free:style=Regular:size=${font-size};5";
        font-2 = "Font Awesome 5 Free:style=Solid:size=${font-size};5";
        font-3 = "Font Awesome 5 Brands:style=Regular:size=${font-size};5";
        font-4 = "Noto Color Emoji:style=Regular:scale=10;4";

        padding = 1;
        # https://en.wikipedia.org/wiki/Thin_space
        separator = " ";
        module-margin = 0;

        modules-left = [ "i3" ];
        modules-center = [ "date" ];
        modules-right = [ "cpu" "memory" "temperature" "cpu" "backlight" ];


        tray-padding = 1;
        tray-position = "right";
        tray-maxsize = 512;

        dpi-x = 200;
        dpi-y = 200;

        scroll-up = "i3-msg workspace next_on_output";
        scroll-down = "i3-msg workspace prev_on_output";
      };

      "module/backlight" = {
        type = "internal/backlight";
        card = "intel_backlight";

        format = " <label>";
        format-padding = 1;
        format-background = colors.background-alt;

        label = "%percentage%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 5;
        label = " %percentage%%";
        label-background = colors.background-alt;
        label-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%F %Z";
        time = "%T";
        label = "%time% %date%";
      };

      "module/i3" = {
        type = "internal/i3";
        strip-wsnumbers = true;
        wrapping-scroll = false;

        label-focused = "%name%";
        label-focused-foreground = colors.foreground-alt;
        label-focused-background = colors.background-alt;
        label-focused-padding = 1;

        label-unfocused = "%name%";
        label-unfocused-padding = 1;

        label-visible = "%name%";
        label-visible-padding = 1;

        label-urgent ="%name%";
        label-urgent-background = colors.alert;
        label-urgent-padding = 1;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 5;
        label = " %percentage_used%%";
        label-background = colors.background-alt;
        label-padding = 1;
      };

      "module/temperature" = rec {
        type = "internal/temperature";

        interval = 5;
        thermal-zone = 1;

        base-temperature = 40;
        warn-temperature = 80;
        units = true;

        format = "<ramp><label>";
        format-background = colors.background-alt;

        label = "%temperature-c%";
        label-background = colors.background-alt;
        label-padding = 1;

        format-warn = "<ramp><label-warn>";
        format-warn-background = colors.alert;

        label-warn = label;
        label-warn-background = colors.alert;
        label-warn-padding = 1;

        ramp-left-padding = 1;
        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
      };
    };

    script = "polybar top &";
  };
}
