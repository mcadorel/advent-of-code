drop table packet;
create table packet as
with input(payload) as (values (
'zdnnfgfsgffgllwrwprwrgwwpssznzrnznllstszsttpdptdpdmdsdzsdscsmcmttdllbsbwwtwnwswcchshlhjhfhwfftcchnnfwwbqwqwrqqgmgzmmwzwfzwfzzzsmzzrczcmmhphzhbbbgdbgddmggwwbbttvmtvttfsfttjlttdfdsdqqczqzffbrfbbfbrrmdrrlslshllwzwrzrzzlqldqdjdjwjvjzjrjjcsszjjqfqnfqqsrqrccbhhwphwhbwwlzwwjwfjwfwzfwzffssvjsjddcsdslslrsrfsrffsggdffrcrcdcpprrzbrzbbtstvvqttbqqgfgsggtvtrvtvbbrqrsqrsqsvsbbzmbmgmvgmmrqrzzbbnjjlwjjfssdrdbrbffwrrrjjgcgtgvvjbjjjsqjsqqncntnndcdrcrhhsgstslldwdbwdbdtbdbggpnndhdvhhvrrlzzfjjffzszvvzgzhhqzqttdhdrrwdwzdwdbwwfsfwsfwfqqzwzbzmzwmmvgggvssvwswfwswhwzzqtqrtthhbbjggjppnpfnfmnnghgrhhtvtqtsttbpprzzwqqfhqfflttzffrprwpwspplzpztptgtltjlttwwsrsrprwrsswnwttcscqsqlsqqhshbhlblnnpznnzlnndrnrcncvcqcjqqvhvppjzjddzbzsztzqqlmlnlnblnlwnllswszwzrzddqhdqhqffhfhjjpbbhvbvmmfhmhcccjlclhcllbrlblddnpplggcmmvddmmqzzmqmppnjpjjjzllqjqccrwwhzhnnlmlhhbbtztvtltvtnvtvltlrtrllbttbzzfwfrrjzjbbmgghjhqhlljnjhhhjzjcjvcvwwzczwcwgcclflnnsvvcncbncnqqpjqjnjwjrrgqrrmqmfmmmjgjfgjfftggqdgqddgcdcdwdrdsswqqphpjhhdjjwswfwfnfqnqccvhvzvmzvzzplzljzjpzzhmzmqzqjjprpvrrhqqnbngnnpvpfvpvqvwwrhhdndqdppmcppzddbzzjcjdjfjnfnngqnnchcqqpllpwppgllcblcblbddzhhqsqbssjqqgmgbgzzvhvnhvnhvvpmpvvlddgppzrprmpmbpbjpbpfptpspddcgddqhdhhthrhjrhrvrlrffvbfbvfvbblssftfnfwwrwnnzdznnbwnbwnwlwttszzmmlzlhhpjhhjvvlvwwdnddzwdwgdgdssflfvfzvznzbzrbzzdssphhgttllcjcvcjjdrdqdhdnndlndldcllcnllslvlnvllmglgnnplpmpzzjwjtwtnntrtjtvjtjffhcfclltppftfwwprrwsrwwzdwzdztzccbmccfcfzczbcbsbqsstjtrrpnnfqqfmmchmmwmrwrwzwztzddgzdgzzfwzzrppcscrrgvgvgvtgtsslrsrvsrrdcdscscwcwqqsccwjcjgjvgvpvnvhhchrrgprpvrvsvsttgghdghhmphmmbvbcbsccdbcbnccbnnsjnjhnnzbnnpjbwdpczcvgjpgwfqrmnvwncflvnttwhfgmfqvngpdhbhvlglfhtdqmqtqcgjcqghzvbdghdgvjcsjrlpqvgcdnbpqrcrcvqqdlcpscqbfpsnhzcdbbcssslrjlzsqpprsbmtqhzblvwbswprhztmpcgfqfsgshchrhjmwwhpzsjzrmrvgdgwjrlwpgqhbzrmnmnnsnvzsrlhthgvlpljsjrpbhbzctdqgvdjcmrgtvqjqbcwsprnfmntzpbjcdtlchhjgwpmldmsstbtztfdbgbstgnlwbzrrzmvbrhnrlcwfgwwbfnntbjspqwngbjrvhdcnblqssgjlbcwbbgphhnmfcmdhqdhsnmvdjnwwwjlffswhsmwqrsprftjwtbtcvmpctgvfqvvcjpnwzqldglfbwfzpnqmdlrdpjmjptvwsctlmhmzzgvplglfgsvrfbqbmrhplczbvqpdjjhhvfqswhzhqfgzstwwpbtbsnnlgpshwqgppzbpsfpfvcntbbbzwdnfcgcwzbqwmhjrhpdfvpbzpmfnmllrcqlqhcbzfltzcgccwwqmtsmwchhvbqtdrnsbrchqqcmtfqpddcjplbvdhhtndrrmfdtmbpdvwthvgdccnrcqmpznlvzqzfjqmpvgjtfbtfjnrmlzhwhljrrqnbqzpfhcvncblfggrtbdfjqnlgpbrzmwcvrvjtjscfmcnfjgqzqsphldvhdbpvmghrvsdmvpmvvdmdhwdghtjltmlcmfhvrsvcvpblwhhfcfdqnrsjbcldgbwhtnjntmgvprhbjrcvsmhgtfphcwncpjtngqhvwrmgprstbtdstmttpzcntmzvncwslqlldpnjbtpmsfnwbpwpnlfgdvcqplvlqqjvfftnnvpcmwjrvwqhlrshftrbhcwnczzsnvtnjnrbzzgzfsqhnfwlcgzvvhqcgvqtmcpnhlvdlmwgsvtwbqgrdsrrddszvscbgtlpwpzjrbvwhjnrpprhtzmthbpfzvplzwfdtnwqwtctgjslmcczjvwplsqwgfnfbgdjbsdpwbgflttvvqlhzgmmpjsnwbqqtcdszfqbhgnmbbmrbrgnrzdmzwnjjzjqcwqcqfchjrzlspgbrchcbgwbhvggsqbvdpzbpnwdtqvcjwcwnbjdhsdfmbtwfbfhzwwtnqzhmtvtbfwrsqjzgssvlwszvlmvbslpncnhmsdhcqqfpftztpzbbhsgbnscddbjlgwgjjndgwbrhwmsfdmmsnlwgwdsdltwjfvwnczjrbgcvsfczppltdptlgcdfzgmqpjngstldqgmwhdmfrwwfqwdgswvfdrtsgtvttpcbnhzbscnchpvfjvbcszbwchnbmfrvsswslbzlhgwlvfchdbfthbpdbwwqtmlgwjqtjhzrjzzmrpdwnvfgrnqdcqmwtttmwjvgcmjsddvtlswldzhtppwvhmlghwlgblfttctnglwhtfvqgjmdjcnflsrjvpjwcjfftbdmmcbqvfwnnnzsltllncbstgnhtmpsltgztqzjbbrtqpcvdlnhpnhvmmztpfpplbqjlpqvfsdvhwvstdmqbtnpzrcbdhvdtghqwcppcfzjfjsfwvqrtfgcdzwgzjvrqqsjtnhlbjcmtjcnmtpffwcwhqqphwjsrhpqvnnhhrcnvztfdjzbjggwlgjprbpssgnmtcrvprwbsrfvvphrsgzgbrfnpgtqbbprhfphqntsglrmhzfnwqptlslnhtrhfprjpdcglcffsblnjwczmgwhmmtgsgwljmqlvdglqmzwmtqcvgcrmqjldlsnbssdvrrtltngvrsqbctqlsngqvcphjvhmwsssgwmvgzdctjcmjtpcjhvfcrfhbffdqfjjvpqwgvnlzhgfnfmlrrfvjrdvhzdcvdvmpncvtjbbnczpzmglfqnpbsrsjwgvszsnqvrnvlhmqjjnmsfngbdlpwbqllcptjtlbhrfdvhlrpdlznpvndjzjdtjflqqjdgjjpmnpmjgcglllgcqbfpvdtpbjdnvrclmnlfdrpbmwzgvdhgbzvbhwqfslhshbfcbwrnsjndgjgccllfbzgmcjqcmdnfftnccphqtwmgqgfqlvlwsrprctchqrscwvgpdrwgcfgzjwmzmmsmwzgtzsjtqfggcczcmghlqgnqqjvsrsfrrmwmnrnhbsszmwsqlrggsbdwzzfnhwcggjszfrlffplvcblvphqmzjnzwzdshhdprfrdbcrmbtztcfvgpzpmmgflswphvnvtwhbbhjwffsvqfjlfvzqmhmsmddwdwsqfnnplbqnptbvgjqgmflsbfdtpvdgbfnqmcqznhpqbpwtbfpqllvqwvcftdjjtlsvzbssbtcdzqqqvzlqhfpdthscqmvhpndmnztthvvzccqswswspnqcbncvszrgjshjhdsclrjdnjdczqmcjldbspclgrmwqdvcvpcsvjggfdqlrwlnzptfvcwjsgblpjzgcrrmjqptvdnwr'
))
select
    row_number() over () as n,
    c
from input, regexp_split_to_table(payload, '') _(c)
;

deallocate rolling_last_characters;
prepare rolling_last_characters(int) as
with four_last_characters as (
    select
        *,
        -- why is distinct not supported in window functions 😩
        array_agg(c) over (
            -- 4 last characters
            order by n
            rows between $1 - 1 preceding and current row
            ) as four_last
    from packet
),
q as (
    select
        n,
        four_last,
        (select count(distinct x) from unnest(four_last) _(x))
    from four_last_characters
    group by 1, 2, 3
    order by 1, 2
)
select *
from q
where count = $1
order by n
limit 1
;

-- part 1
execute rolling_last_characters(4);

-- part 2
execute rolling_last_characters(14);