![rice](https://i.ibb.co/bPyHyT2/s2.png)
---

Hello 👋, This is the repository for my debian configuration files,
Using the following software:
- Window Manager: awesome
- Editor: neovim
- Terminal: st
- Browser: firefox


<details>
<summary>Installation</summary>
<p>

```sh
git clone --depth 1 https://github.com/undefinedDarkness/rice.git # Clone The Repository
cd rice
make pre-install
```

### Firefox Tabs
1. Toggle [Firefox Extension Verification](https://stackoverflow.com/questions/31952727/how-can-i-disable-signature-checking-for-firefox-add-on)
2. Flip `svg.context-properties.content.enabled` to true (Important for Firefox CSS)
3. Flip `toolkit.legacyUserProfileCustomizations.stylesheets` to true (Important for Firefox CSS)
4. Run `make install` in ./misc/extension
5. Install extension from ./misc/extension/ext.zip (Install from file)

</p>
</details>

## Colors
This is using the [base16 tomorrow night](http://gg.gg/vyf7h) colorscheme, Its basic colors are:
<table>
<tr>
<th>Black</th>
<th>Red</th>
<th>Blue</th>
<th>Yellow</th>
<th>Green</th>
<th>Brown</th>
<th>White</th>
</tr>
<tr>
<td><img src="https://via.placeholder.com/50/1d1f21/000000?text=+"/></td>
<td><img src="https://via.placeholder.com/50/cc6666/000000?text=+"/></td>
<td><img src="https://via.placeholder.com/50/8abeb7/000000?text=+"/></td>
<td><img src="https://via.placeholder.com/50/f0c674/000000?text=+"/></td>
<td><img src="https://via.placeholder.com/50/b5bd68/000000?text=+"/></td>
<td><img src="https://via.placeholder.com/50/a3685a/000000?text=+"/></td>
<td><img src="https://via.placeholder.com/50/e0e0e0/000000?text=+"/></th>
</tr>
</table>


## Todo
- [ ] Document rice
- [ ] Verify firefox extension
