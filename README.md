# Dotfiles

I really like to configure my system in every possible way. This repository
holds how I do it. If you are just starting out you could use mine but for your own sake **read them**. You
will not get the most out of it without.

## Pre Requirements

- [Regolith Linux](https://regolith-linux.org/)

## :rocket: Installing

I follow a very modular approach. If you don't want something you can just
remove it's folder. Imagine you don't want Neovim. You can just delete `nvim`
folder. It's that simple.

Start by cloning my `dotfiles` into `~/dotfiles`.

If you don't want ssh then delete the ssh folder else open ssh/install.sh in your code editor, then change the email to yours then save it

```shell
email="yourEmail@example.com"
```

Install

```shell
cd ~/dotfiles
make install

# After install Oh.My.Zsh, please run it again
make install
```

## :bomb: Uninstalling (Comming Soon)

```shell
cd ~/dotfiles
make uninstall
cd ~
rm -rf ~/dotfiles
```

## :warning: Disclaimer

As you probably know, you shouldn't just run my Makefile without reading it
first. And if you read it, you will understand that it calls other scripts like
`install.sh` which depend on `helpers.sh`. Read those, it's the only way that
you can trust what it is doing.

## After Install

Add SSH key to your GitHub Account

[How to Setup SSH Keys on GitHub](https://devconnected.com/how-to-setup-ssh-keys-on-github/)

## Preview

- Editor - VsCode
- Theme - Palenight, using Pale night Operator
- Editor Font Family - Operator Mono with font ligatures
- Transparent Background - Devilspie (linux)

![](https://lh3.googleusercontent.com/-41GubJ28nQM/XfOpzP0vqhI/AAAAAAAABF0/6hSyyiuqDQQ7PWPJB5xFfwDmwtUDYfRkQCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-13%2B20-34-50.png)

- I'm using i3 tiling window manager (linux)
- Bottom-Right, did you see the time, day and date there - Variety (linux)
- Background Images Changing using - Variety

![](https://lh3.googleusercontent.com/-1jVvjdDqTJ8/XfOrrgvW6ZI/AAAAAAAABGc/7S-Bt7HFgPYKeF-39y9we76V9rdbotYFgCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-13%2B20-47-23.png)

- Kitty Terminal
- I customize the terminal to make it look like palenight theme
- Termainl Font Family - Operator Mono with font ligatures
- Transparent Background - Devilspie (linux)

![](https://lh3.googleusercontent.com/-_O6qhKbSvBI/XfOzXkipepI/AAAAAAAABHQ/ivME9tRS7aIYOZsJ3JLLp3ihKGblYcsAACK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-13%2B21-20-00.png)

- File Manager - ranger (linux)

![](https://lh3.googleusercontent.com/-ZAOtRn3Kgd0/XfOz6wHVTVI/AAAAAAAABHk/8PfRNpluvwcgc7XEFzB1HiPJPbhfvapowCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-13%2B21-22-39.png)

- Preview Images inside ranger

![](https://lh3.googleusercontent.com/-uB0idAiC0KM/XfZGGaA40xI/AAAAAAAABLc/2TuaBNabi8IFmLbVe-kMOomTHf7-Q_4kQCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-15%2B16-56-10.png)

![](https://lh3.googleusercontent.com/-EfXK-WAqS60/XfZGKpHNmgI/AAAAAAAABLo/aa0GEzpIBDQAQw1-s3-fhasTIrx2xaWPQCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-15%2B16-59-28.png)

- Preview Videos inside ranger

![](https://lh3.googleusercontent.com/-yCbt4CRjI_o/XfZHCFY_EkI/AAAAAAAABMI/HzLL6LaW7JkIZ1m5Bfc1Y5lAomrtlyT0QCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-15%2B17-04-02.png)

- Preview Svg inside ranger

![](https://lh3.googleusercontent.com/-82cDJ3UZ3Ic/XfZHnICj45I/AAAAAAAABNA/OmILiwXB-b0rXtygcGREX-m5w2jaOnXnwCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-15%2B17-20-31.png)

- Preview zip inside ranger

![](https://lh3.googleusercontent.com/-dtiFlOVeLvc/XfZHt18sSUI/AAAAAAAABNM/sXmBxaDXWdkGLujNnQ6_tD2cMxEdwKNoACK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-15%2B17-17-49.png)

- Preview code with highlights inside ranger

![](https://lh3.googleusercontent.com/-2AjyK-9uK4I/XfZH26EPSfI/AAAAAAAABNc/cnT-XbbSgTYY4VccA-zfIPrcR6k8yFLGQCK8BGAsYHg/s0/Screenshot%2Bfrom%2B2019-12-15%2B17-05-19.png)
