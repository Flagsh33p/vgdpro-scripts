--超声尖叫
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	--【自】：这个单位从手牌登场到R时，通过【费用】[计数爆发1]，查看你的牌堆顶的3张卡，选择1张卡，放置到灵魂里，然后牌堆洗切，你的灵魂里有4张以上的相互不同等级的卡的话，抽1张卡。
	vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_SINGLE,EVENT_SPSUMMON_SUCCESS,cm.operation,VgF.DamageCost(1),cm.condition)
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return VgF.RMonsterFilter(e:GetHandler()) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sc=g:Select(tp,1,1,nil):GetFirst()
	Duel.Overlay(VgF.GetVMonster(tp),sc)
	if VgF.GetVMonster(tp):GetOverlayGroup():GetClassCount(Card.GetLevel)>=4
	then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
