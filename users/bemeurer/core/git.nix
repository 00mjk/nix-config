{ pkgs, ... }: {
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options.syntax-theme = "Nord";
    };
    package = pkgs.gitFull;
    lfs.enable = false;
    userEmail = "bernardo@meurer.org";
    userName = "Bernardo Meurer";
    extraConfig = {
      diff.colorMoved = "default";
      difftool.prompt = true;
      github.user = "lovesegfault";
      mergetool.prompt = true;
      init.defaultBranch = "main";
    };
  };

  programs.zsh.shellAliases = rec {
    g = "git";
    ga = "git add";
    gaa = "${ga} -A";
    gaap = "${gaa} --patch";
    gap = "${ga} --patch";
    gb = "git branch";
    gch = "git checkout";
    gcl = "git clone";
    gco = "git commit";
    gcom = "${gco} --message";
    gcoa = "${gco} --amend";
    gcoan = "${gcoa} --no-edit";
    gdf = "git diff";
    gdfs = "${gdf} --staged";
    gdt = "git difftool";
    gdts = "${gdt} --staged";
    gf = "git fetch --all --prune --tags";
    gfpl = "${gf} && ${gpl}";
    gff = "${gf} --force";
    gl = "git log --decorate --pretty=format:'%C(auto)%h %C(green)(%as)%C(reset)%C(blue) %<(20,trunc) %an%C(reset) %s%C(auto)%d'";
    gm = "git merge";
    gma = "${gm} --abort";
    gmc = "${gm} --continue";
    gpl = "git pull --rebase";
    gps = "git push";
    grb = "git rebase";
    grba = "${grb} --abort";
    grbc = "${grb} --continue";
    grbsn = "${grb} --exec 'git commit --amend --no-edit -n -S'";
    grs = "git restore";
    grss = "${grs} --staged";
    # TODO: deprecate
    gs = "git status";
    gst = "git status";
    gsw = "git switch";
    gswc = "${gsw} -c";
    gswcf = "${gsw} -C";
  };
}
