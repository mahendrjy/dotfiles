# Dotfiles

## Pre Requirements

- [Regolith Linux](https://regolith-linux.org/)

## Setup

- Fork this repo
- Open regolith.sh, change the email then save it

```bash
email="yourEmail@example.com"
```

- In Readme, at Install, change `iampika` to your github username, then run it

```bash
git clone https://github.com/yourUserName/dotfiles.git
```

## Install

```bash
git clone https://github.com/iampika/dotfiles.git &&
cd dotfiles &&
chmod +x regolith.sh &&
./regolith.sh
```

## After Install

#### Copy SSH key

```bash
xclip -sel clip < ~/.ssh/id_rsa.pub
```

#### Add SSH key to your GitHub Account

- Go to settings

- Click on SSH and GPG keys
  ![Click on SSH and GPG keys](https://devconnected.com/wp-content/uploads/2019/10/ssh-gpg.png)

- Click on New SSH key
  ![Click on New SSH key](https://devconnected.com/wp-content/uploads/2019/10/ssh-key-create-768x284.png)

- Write any Title, eg. Private, Pika

- Paste the key
  ![Write any Title, eg. Private, Pika](https://devconnected.com/wp-content/uploads/2019/10/public-key-github-768x422.png)

- Click on Add SSH key
  ![Click on Add SSH key](https://devconnected.com/wp-content/uploads/2019/10/ssh-keys.png)

#### Test GitHub SSH Keys

```bash
git clone git@github.com:yourUserName/private-repo.git
```

![Clone with SSH](https://devconnected.com/wp-content/uploads/2019/10/clone-download.png)

Example

```bash
git clone git@github.com:iampika/dotfiles.git
```

## Preview

- Editor - VsCode
- Theme - Palenight, using Palenight Operator
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
