return {
    "L3MON4D3/LuaSnip",
    config = function()
        local ls = require("luasnip")
        local fmt = require("luasnip.extras.fmt").fmt
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node

        local clg_snippet = s("clg", {
            t('console.log('),
            i(1),
            t(')')

        })
        local function get_filename_without_extension()
            local filename = vim.fn.expand("%:t"):gsub("%..*$", "")  -- Убираем расширение
            if not filename:find("-") then
                return filename:sub(1, 1):upper() ..
                filename:sub(2)                                      -- Первую букву делаем заглавной
            end
            return filename:gsub("-(%a)", function(c)
                return c:upper()
            end):gsub("^%l", string.upper) -- Делаем каждое слово с заглавной буквы
        end
        ls.add_snippets("lua", {
            s("hello", {
                t('print("hello '),
                i(1),
                t(' world")')
            }),
            s("if", {
                t("if "),
                i(1, "true"),
                t(' then '),
                i(2),
                t(' end')
            })
        })
        ls.add_snippets("typescript", {
            clg_snippet,
            s("try", fmt(
                [[
                try {a}
                {c}
                {b} catch(err) {a}
                console.log(err)
                {b}
                ]],
                { a = t("{"), b = t("}"), c = i(1) }
            ))
        })
        ls.add_snippets("javascript", {
            clg_snippet
        })
        ls.add_snippets("typescriptreact", {
            clg_snippet,
            s("tsfc", fmt(
                [[
                type {a}Props = {b}
                {}
                {c}
                const {a} = ({b}{}{c}: {a}Props) => {b}
                return (
                    {}
                )
                {c}
                export default {a}
                ]],
                { a = f(get_filename_without_extension), b = t("{"), i(1), i(2), i(3), c = t("}") })),
                s("tsfun", fmt(
                    [[
                    export default function {a}() {b}
                    return (
                        <div></div>
                    )
                    {c}
                    ]],
                    { a = f(get_filename_without_extension), b = t("{"), c = t("}") }
                ))
            })

            ls.setup({
                ext_opts = {
                    [require("luasnip.util.types").choiceNode] = { passive = { hl_group = nil } },
                    [require("luasnip.util.types").insertNode] = { passive = { hl_group = nil } },
                }
            })
        end
    }
